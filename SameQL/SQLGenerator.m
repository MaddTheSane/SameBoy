//
//  SQLGenerator.c
//  SameQL
//
//  Created by C.W. Betts on 2/12/23.
//

#include "SQLGenerator.h"
#include <Cocoa/Cocoa.h>
#include "get_image_for_rom.h"

OSStatus SQLRender(CGContextRef cgContext, CFURLRef url, bool showBorder)
{
    /* Load the template NSImages when generating the first thumbnail */
    static NSImage *template = nil;
    static NSImage *templateUniversal = nil;
    static NSImage *templateColor = nil;
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        bundle = [NSBundle bundleWithIdentifier:@"com.github.maddthesane.SameQL"];
    });
    if (showBorder) {
        dispatch_once(&onceToken, ^{
            template = [bundle imageForResource:@"CartridgeTemplate"];
            templateUniversal = [bundle imageForResource:@"UniversalCartridgeTemplate"];
            templateColor = [bundle imageForResource:@"ColorCartridgeTemplate"];
        });
    }
    //Sanity check: Are the inputs valud?
    if (cgContext == NULL || url == NULL) {
        return -50;// paramErr;
    }
    uint32_t bitmap[160*144];
    uint8_t cgbFlag = 0;
    
    /* The cgb_boot_fast boot ROM skips the boot animation */
    if (get_image_for_rom([(__bridge NSURL *)url fileSystemRepresentation],
                          [[bundle URLForResource:@"cgb_boot_fast" withExtension:@"bin"] fileSystemRepresentation],
                          bitmap, &cgbFlag)) {
        return -36;// ioErr;
    }
    
    /* Convert the screenshot to a CGImageRef */
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmap, sizeof(bitmap), NULL);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(160,
                                    144,
                                    8,
                                    32,
                                    4 * 160,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,
                                    NULL,
                                    true,
                                    renderingIntent);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpaceRef);
    CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithCGContext:cgContext flipped:false];
    [NSGraphicsContext setCurrentContext:context];
    
    
    /* Convert the screenshot to a magnified NSImage */
    NSImage *screenshot = [[NSImage alloc] initWithCGImage:iref size:NSMakeSize(160, 144)];
    CGImageRelease(iref);
    /* Draw the screenshot */
    if (showBorder) {
        [screenshot drawInRect:NSMakeRect(192, 150, 640, 576)];
    }
    else {
        [screenshot drawInRect:NSMakeRect(0, 0, 640, 576)];
    }
    
    if (showBorder) {
        /* Use the CGB flag to determine the cartridge "look":
         - DMG cartridges are grey
         - CGB cartridges are transparent
         - CGB cartridges that support DMG systems are black
         */
        NSImage *effectiveTemplate = nil;
        switch (cgbFlag) {
            case 0xC0:
                effectiveTemplate = templateColor;
                break;
            case 0x80:
                effectiveTemplate = templateUniversal;
                break;
            default:
                effectiveTemplate = template;
        }
        
        /* Mask it with the template (The middle part of the template image is transparent) */
        [effectiveTemplate drawInRect:(NSRect){NSZeroPoint, template.size}];
    }
    
    return noErr;
}
