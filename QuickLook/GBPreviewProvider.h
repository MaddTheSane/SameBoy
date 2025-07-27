#import <Foundation/Foundation.h>
#import <QuickLookThumbnailing/QuickLookThumbnailing.h>
#if TARGET_OS_OSX
#import <QuickLookUI/QuickLookUI.h>
#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#else
#import <QuickLook/QLPreviewProvider.h>
#import <QuickLook/QLPreviewingController.h>
#import <QuickLook/QLPreviewReply.h>
#import <QuickLook/QLFilePreviewRequest.h>
#endif

API_AVAILABLE(macos(12.0))
@interface GBPreviewProvider : QLPreviewProvider <QLPreviewingController>
@end
