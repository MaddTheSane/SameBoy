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

extern OSStatus SQLRender(CGContextRef cgContext, CFURLRef url, bool showBorder);

#endif /* SQLGenerator_h */
