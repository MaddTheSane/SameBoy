#import <Foundation/Foundation.h>



typedef NS_ENUM(int, JOYButtonUsage) {
    JOYButtonUsageNone,
    JOYButtonUsageA,
    JOYButtonUsageB,
    JOYButtonUsageC,
    JOYButtonUsageX,
    JOYButtonUsageY,
    JOYButtonUsageZ,
    JOYButtonUsageStart,
    JOYButtonUsageSelect,
    JOYButtonUsageHome,
    JOYButtonUsageMisc,
    JOYButtonUsageLStick,
    JOYButtonUsageRStick,
    JOYButtonUsageL1,
    JOYButtonUsageL2,
    JOYButtonUsageL3,
    JOYButtonUsageR1,
    JOYButtonUsageR2,
    JOYButtonUsageR3,
    JOYButtonUsageDPadLeft,
    JOYButtonUsageDPadRight,
    JOYButtonUsageDPadUp,
    JOYButtonUsageDPadDown,
    
    JOYButtonUsageSlider,
    JOYButtonUsageDial,
    JOYButtonUsageWheel,
    
    JOYButtonUsageRudder,
    JOYButtonUsageThrottle,
    JOYButtonUsageAccelerator,
    JOYButtonUsageBrake,
    
    JOYButtonUsageNonGenericMax,
    
    JOYButtonUsageGeneric0 = 0x10000,
};

@interface JOYButton : NSObject
@property (nonatomic, readonly, copy) NSString *usageString;
+ (NSString *)usageToString: (JOYButtonUsage) usage;
@property (nonatomic, readonly) uint64_t uniqueID;
@property (readonly, getter=isPressed) bool pressed;
@property JOYButtonUsage usage;
@end


