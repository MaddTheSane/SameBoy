//
//  MetalShaders.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"

#include "AAScale4x.fsh"

#define fragment_shader fragment_shader_AAScale4x
#include "BaseFragment.h"

#define scale scale2
STATIC vec4 scale2(sampler2D image, float2 position, float2 input_resolution, float2 output_resolution)
{
    return mix(texture(image, position), scale2x(image, position, input_resolution, output_resolution), 0.5);
}

#undef fragment_shader
#define fragment_shader fragment_shader_AAScale2x
#include "BaseFragment.h"
