//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "AAOmniScaleLegacy.fsh"

#define fragment_shader fragment_shader_AAOmniScaleLegacy
#include "BaseFragment.h"
