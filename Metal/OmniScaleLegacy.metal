//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "../Shaders/OmniScaleLegacy.fsh"

#define fragment_shader fragment_shader_OmniScaleLegacy
#include "BaseFragment.h"
