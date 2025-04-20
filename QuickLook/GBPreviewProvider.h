#import <Foundation/Foundation.h>
#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#else
#import <QuickLook/QuickLook.h>
#import <QuickLookThumbnailing/QuickLookThumbnailing.h>
#endif

API_AVAILABLE(macos(12.0))
@interface GBPreviewProvider : QLPreviewProvider <QLPreviewingController>
@end
