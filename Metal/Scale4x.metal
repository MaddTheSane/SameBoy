//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "Scale4x.fsh"

#define fragment_shader fragment_shader_Scale4x
#include "BaseFragment.h"
