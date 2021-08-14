#import <Foundation/Foundation.h>

@interface JOYHat : NSObject
@property (nonatomic, readonly) uint64_t uniqueID;
@property (nonatomic, readonly) double angle;
@property (nonatomic, readonly) unsigned resolution;
@property (readonly, getter=isPressed) bool pressed;

@end


