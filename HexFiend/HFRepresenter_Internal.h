#import <HexFiend/HFRepresenter.h>

@interface HFRepresenter (/*HFInternalStuff*/)

@property (readwrite, weak, setter=_setController:) HFController *controller;

@end
