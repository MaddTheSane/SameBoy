#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#define NSView UIView
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

#import <Core/gb.h>

typedef enum GB_frame_blending_mode_e {
    GB_FRAME_BLENDING_MODE_DISABLED,
    GB_FRAME_BLENDING_MODE_SIMPLE,
    GB_FRAME_BLENDING_MODE_ACCURATE,
    GB_FRAME_BLENDING_MODE_ACCURATE_EVEN = GB_FRAME_BLENDING_MODE_ACCURATE,
    GB_FRAME_BLENDING_MODE_ACCURATE_ODD,
} GB_frame_blending_mode_t;

@interface GBViewBase : NSView
{
    @public
    GB_gameboy_t *_gb;
}

@property (nonatomic) GB_gameboy_t *gb;
@property (nonatomic) GB_frame_blending_mode_t frameBlendingMode;
@property (nonatomic, strong) NSView *internalView;
- (void) flip;
@property (readonly) uint32_t *pixels NS_RETURNS_INNER_POINTER;
- (void)screenSizeChanged;
- (void) createInternalView;
@property (readonly) uint32_t *currentBuffer NS_RETURNS_INNER_POINTER;
@property (readonly) uint32_t *previousBuffer NS_RETURNS_INNER_POINTER;
- (instancetype)mirroredView;
@end
