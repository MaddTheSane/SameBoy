#import <Cocoa/Cocoa.h>

@interface GBOSDView : NSView
@property (nonatomic) bool usesSGBScale;
- (void)displayText:(NSString *)text;
@end
