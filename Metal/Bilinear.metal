//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "../Shaders/Bilinear.fsh"

#define fragment_shader fragment_shader_Bilinear
#include "BaseFragment.h"
