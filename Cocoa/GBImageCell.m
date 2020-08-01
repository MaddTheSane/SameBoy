#import "GBImageCell.h"

@implementation GBImageCell
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    CGContextRef context;
    if (@available(macOS 10.10, *)) {
        context = [[NSGraphicsContext currentContext] CGContext];
    } else {
        context = [[NSGraphicsContext currentContext] graphicsPort];
    }
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    [super drawWithFrame:cellFrame inView:controlView];
}
@end
