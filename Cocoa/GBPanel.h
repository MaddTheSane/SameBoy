#import <Foundation/Foundation.h>
#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>

@interface GBPanel : NSPanel
@property (weak) IBOutlet NSWindow *ownerWindow;
@end
#else
@interface GBPanel : NSObject

@end
#endif
