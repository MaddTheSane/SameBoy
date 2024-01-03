//
//  SQLGenerator.h
//  SameQL
//
//  Created by C.W. Betts on 2/12/23.
//

#ifndef SQLGenerator_h
#define SQLGenerator_h

#include <CoreFoundation/CoreFoundation.h>
#include <CoreGraphics/CoreGraphics.h>

CF_ASSUME_NONNULL_BEGIN

extern OSStatus SQLRender(CGContextRef cgContext, CFURLRef url, bool showBorder);

CF_ASSUME_NONNULL_END

#endif /* SQLGenerator_h */
