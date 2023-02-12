#import <Foundation/Foundation.h>
#import "JOYInput.h"

@interface JOYHat : JOYInput
@property (nonatomic, readonly) double angle;
@property (nonatomic, readonly) unsigned resolution;
@property (readonly, getter=isPressed) bool pressed;

@end


