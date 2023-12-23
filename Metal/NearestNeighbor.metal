//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "NearestNeighbor.fsh"

#define fragment_shader fragment_shader_NearestNeighbor
#include "BaseFragment.h"
