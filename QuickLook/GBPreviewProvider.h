#import <Foundation/Foundation.h>
#import <QuickLookThumbnailing/QuickLookThumbnailing.h>
#import <QuickLookUI/QuickLookUI.h>
#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#endif

API_AVAILABLE(macos(12.0))
@interface GBPreviewProvider : QLPreviewProvider <QLPreviewingController>
@end
