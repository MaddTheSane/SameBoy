#import <Foundation/Foundation.h>
#import "GBView.h"

@interface GBGLShader : NSObject
- (instancetype)initWithName:(NSString *) shaderName;
- (void) renderBitmap: (void *)bitmap previous:(void*) previous sized:(NSSize)srcSize inSize:(NSSize)dstSize scale: (double) scale withBlendingMode: (GBFrameBlendingMode)blendingMode;
@end
