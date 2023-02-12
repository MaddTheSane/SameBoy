#import <Foundation/Foundation.h>
#import "JOYInput.h"

typedef NS_ENUM(int, JOYAxes2DUsage) {
    JOYAxes2DUsageNone,
    JOYAxes2DUsageLeftStick,
    JOYAxes2DUsageRightStick,
    JOYAxes2DUsageMiddleStick,
    JOYAxes2DUsagePointer,
    JOYAxes2DUsageNonGenericMax,
    
    JOYAxes2DUsageGeneric0 = 0x10000,
};

@interface JOYAxes2D : JOYInput
+ (NSString *)usageToString: (JOYAxes2DUsage) usage;
@property (nonatomic, readonly) double distance;
@property (nonatomic, readonly) double angle;
@property (nonatomic, readonly) NSPoint value;
@property JOYAxes2DUsage usage;
@end


