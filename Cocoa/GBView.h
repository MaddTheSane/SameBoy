#import <Cocoa/Cocoa.h>
#include <Core/gb.h>
#import <JoyKit/JoyKit.h>

typedef NS_ENUM(NSInteger, GB_frame_blending_mode_t) {
    GB_FRAME_BLENDING_MODE_DISABLED,
    GB_FRAME_BLENDING_MODE_SIMPLE,
    GB_FRAME_BLENDING_MODE_ACCURATE,
    GB_FRAME_BLENDING_MODE_ACCURATE_EVEN = GB_FRAME_BLENDING_MODE_ACCURATE,
    GB_FRAME_BLENDING_MODE_ACCURATE_ODD,
};

@interface GBView : NSView<JOYListener>
- (void) flip;
- (uint32_t *) pixels;
@property GB_gameboy_t *gb;
@property (nonatomic) GB_frame_blending_mode_t frameBlendingMode;
@property (getter=isMouseHidingEnabled) BOOL mouseHidingEnabled;
@property bool isRewinding;
@property NSView *internalView;
- (void) createInternalView;
- (uint32_t *)currentBuffer;
- (uint32_t *)previousBuffer;
- (void)screenSizeChanged;
- (void)setRumble: (double)amp;
@end
