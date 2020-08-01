#import <Cocoa/Cocoa.h>
#include <Core/gb.h>
#import <JoyKit/JoyKit.h>

typedef NS_ENUM(NSInteger, GBFrameBlendingMode) {
    GBFrameBlendingModeDisabled,
    GBFrameBlendingModeSimple,
    GBFrameBlendingModeAccurate,
    GBFrameBlendingModeAccurateEven = GBFrameBlendingModeAccurate,
    GBFrameBlendingModeOdd,
};

@interface GBView : NSView<JOYListener>
- (void) flip;
- (uint32_t *) pixels;
@property GB_gameboy_t *gb;
@property (nonatomic) GBFrameBlendingMode frameBlendingMode;
@property (getter=isMouseHidingEnabled) BOOL mouseHidingEnabled;
@property bool isRewinding;
@property NSView *internalView;
- (void) createInternalView;
- (uint32_t *)currentBuffer;
- (uint32_t *)previousBuffer;
- (void)screenSizeChanged;
- (void)setRumble: (double)amp;
@end
