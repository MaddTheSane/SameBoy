#import <Foundation/Foundation.h>
#include "get_image_for_rom.h"

#if TARGET_OS_OSX
#include <QuickLook/QuickLook.h>
#import <Cocoa/Cocoa.h>
typedef NSImage TheImageType;
#else
#import <UIKit/UIKit.h>
typedef UIImage TheImageType;
#endif

OSStatus GBQuickLookRender(CGContextRef cgContext, CFURLRef url, bool showBorder)
{
    /* Load the template NSImages when generating the first thumbnail */
    static TheImageType *template = nil;
    static TheImageType *templateUniversal = nil;
    static TheImageType *templateColor = nil;
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleForClass:NSClassFromString(@"GBPanel")];
    });
    if (showBorder) {
        static dispatch_once_t onceToken;
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
    uint32_t bitmap[160*144];
    uint8_t cgbFlag = 0;
    
    /* The cgb_boot_fast boot ROM skips the boot animation */
    if (get_image_for_rom([(__bridge NSURL *)url fileSystemRepresentation],
                          [[bundle URLForResource:@"cgb_boot_fast" withExtension:@"bin"] fileSystemRepresentation],
                          bitmap, &cgbFlag)) {
        return -1;
    }
    
    /* Convert the screenshot to a CGImageRef */
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmap, sizeof(bitmap), NULL);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | (CGBitmapInfo)(kCGImageAlphaNoneSkipLast);
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
    CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
#if TARGET_OS_OSX
    [NSGraphicsContext saveGraphicsState];
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithCGContext:cgContext flipped:false];
    [NSGraphicsContext setCurrentContext:context];
#else
    UIGraphicsPushContext(cgContext);
#endif
    
    
    double ratio = CGBitmapContextGetWidth(cgContext) / 1024.0;
    
    /* Convert the screenshot to a magnified NSImage */
    TheImageType *screenshot;
#if TARGET_OS_OSX
    screenshot = [[NSImage alloc] initWithCGImage:iref size:NSMakeSize(160, 144)];
#else
    screenshot = [[UIImage alloc] initWithCGImage:iref];
#endif
    /* Draw the screenshot */
    if (showBorder) {
        [screenshot drawInRect:CGRectMake(192 * ratio, 150 * ratio, 640 * ratio, 576 * ratio)];
    }
    else {
        [screenshot drawInRect:CGRectMake(0, 0, 640, 576)];
    }
    
    if (showBorder) {
        /* Use the CGB flag to determine the cartridge "look":
         - DMG cartridges are grey
         - CGB cartridges are transparent
         - CGB cartridges that support DMG systems are black
         */
        TheImageType *effectiveTemplate = nil;
        switch (cgbFlag) {
            case 0xC0:
                effectiveTemplate = templateColor;
                break;
            case 0x80:
                effectiveTemplate = templateUniversal;
                break;
            default:
                effectiveTemplate = template;
                break;
        }
        
        CGContextSetInterpolationQuality(cgContext, kCGInterpolationMedium);
        /* Mask it with the template (The middle part of the template image is transparent) */
        [effectiveTemplate drawInRect:(CGRect){{0, 0}, {CGBitmapContextGetWidth(cgContext), CGBitmapContextGetHeight(cgContext)}}];
    }
    
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    CGImageRelease(iref);
#if TARGET_OS_OSX
    [NSGraphicsContext restoreGraphicsState];
#else
    UIGraphicsPopContext();
#endif
    
    return noErr;
}

#if TARGET_OS_OSX
OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    @autoreleasepool {
        CGContextRef cgContext = QLPreviewRequestCreateContext(preview, NSMakeSize(640, 576), true, nil);
        if (GBQuickLookRender(cgContext, url, false) == noErr) {
            QLPreviewRequestFlushContext(preview, cgContext);
            CGContextRelease(cgContext);
            return noErr;
        }
        CGContextRelease(cgContext);
        return -1;
    }
}

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    extern NSString *kQLThumbnailPropertyIconFlavorKey;
    @autoreleasepool {
        CGContextRef cgContext = QLThumbnailRequestCreateContext(thumbnail, NSMakeSize(1024, 1024), true, (__bridge CFDictionaryRef)(@{kQLThumbnailPropertyIconFlavorKey : @0}));
        if (GBQuickLookRender(cgContext, url, true) == noErr) {
            QLThumbnailRequestFlushContext(thumbnail, cgContext);
            CGContextRelease(cgContext);
            return noErr;
        }
        CGContextRelease(cgContext);
        return -1;
    }
}
#endif
