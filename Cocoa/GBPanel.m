#import "GBPanel.h"

#if TARGET_OS_OSX
@implementation GBPanel
- (void)becomeKeyWindow
{
    if ([_ownerWindow canBecomeMainWindow]) {
        [_ownerWindow makeMainWindow];
    }
    [super becomeKeyWindow];
}
@end
#else
@implementation GBPanel
@end
#endif
