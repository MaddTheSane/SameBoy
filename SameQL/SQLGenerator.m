//
//  SQLGenerator.c
//  SameQL
//
//  Created by C.W. Betts on 2/12/23.
//

#include "SQLGenerator.h"
#import <Foundation/Foundation.h>
#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#else
#import <UIKit/UIKit.h>
#define NSImage UIImage
#endif
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
#if TARGET_OS_OSX
            template = [bundle imageForResource:@"CartridgeTemplate"];
            templateUniversal = [bundle imageForResource:@"UniversalCartridgeTemplate"];
            templateColor = [bundle imageForResource:@"ColorCartridgeTemplate"];
#else
            template = [UIImage imageNamed:@"CartridgeTemplate" inBundle:bundle withConfiguration:nil];
            templateUniversal = [UIImage imageNamed:@"UniversalCartridgeTemplate" inBundle:bundle withConfiguration:nil];
            templateColor = [UIImage imageNamed:@"ColorCartridgeTemplate" inBundle:bundle withConfiguration:nil];
#endif
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
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
    const CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | (CGBitmapInfo)(kCGImageAlphaNoneSkipLast);
    const CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
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
#if TARGET_OS_OSX
    [NSGraphicsContext saveGraphicsState];
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithCGContext:cgContext flipped:false];
    [NSGraphicsContext setCurrentContext:context];
    
    
    /* Convert the screenshot to a magnified NSImage */
    NSImage *screenshot = [[NSImage alloc] initWithCGImage:iref size:NSMakeSize(160, 144)];
#else
    UIGraphicsPushContext(cgContext);
    UIImage *screenshot = [UIImage imageWithCGImage:iref];
#endif
    CGImageRelease(iref);
    /* Draw the screenshot */
    if (showBorder) {
        [screenshot drawInRect:CGRectMake(192, 150, 640, 576)];
    } else {
        [screenshot drawInRect:CGRectMake(0, 0, 640, 576)];
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
        [effectiveTemplate drawInRect:(CGRect){CGPointZero, template.size}];
    }
#if TARGET_OS_OSX
    [NSGraphicsContext restoreGraphicsState];
#else
    UIGraphicsPopContext();
#endif
    
    return noErr;
}
