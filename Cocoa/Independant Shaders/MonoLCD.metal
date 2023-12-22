//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "MonoLCD.fsh"

#define fragment_shader fragment_shader_MonoLCD
#include "BaseFragment.h"
