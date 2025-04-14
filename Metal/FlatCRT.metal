//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "FlatCRT.fsh"

#define fragment_shader fragment_shader_FlatCRT
#include "BaseFragment.h"
