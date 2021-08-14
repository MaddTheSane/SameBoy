#import "JOYController.h"
#include <IOKit/hid/IOHIDLib.h>

@interface JOYMultiplayerController : JOYController
- (instancetype)initWithDevice:(IOHIDDeviceRef) device reportIDFilters:(NSArray <NSArray <NSNumber *> *>*) reportIDFilters hacks:(NSDictionary *)hacks;
@end


