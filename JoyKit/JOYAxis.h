#import <Foundation/Foundation.h>
#import "JOYButton.h"
#import "JOYInput.h"

typedef NS_ENUM(int, JOYAxisUsage) {
    JOYAxisUsageNone,
    JOYAxisUsageL1,
    JOYAxisUsageL2,
    JOYAxisUsageL3,
    JOYAxisUsageR1,
    JOYAxisUsageR2,
    JOYAxisUsageR3,
    
    JOYAxisUsageSlider,
    JOYAxisUsageDial,
    JOYAxisUsageWheel,
    
    JOYAxisUsageRudder,
    JOYAxisUsageThrottle,
    JOYAxisUsageAccelerator,
    JOYAxisUsageBrake,
    
    JOYAxisUsageNonGenericMax,
    
    JOYAxisUsageGeneric0 = 0x10000,
};

@interface JOYAxis : JOYInput
+ (NSString *)usageToString: (JOYAxisUsage) usage;
@property (nonatomic, readonly) double value;
@property (nonatomic, readonly) JOYButtonUsage equivalentButtonUsage;
@property JOYAxisUsage usage;
@end


