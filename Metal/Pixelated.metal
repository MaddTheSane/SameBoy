//
//  Pixelated.metal
//  SameBoy
//
//  Created by C.W. Betts on 11/18/26.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "../Shaders/Pixelated.fsh"

#define fragment_shader fragment_shader_Pixelated
#include "BaseFragment.h"
