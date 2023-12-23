//
//  BaseMetal.metal
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#include <metal_stdlib>
#include "MetalShared.h"
using namespace metal;


// Vertex Function
vertex rasterizer_data vertex_shader(uint index [[ vertex_id ]],
                                     constant vector_float2 *vertices [[ buffer(0) ]])
{
    rasterizer_data out;

    out.position.xy = vertices[index].xy;
    out.position.z = 0.0;
    out.position.w = 1.0;
    out.texcoords = (vertices[index].xy + float2(1, 1)) / 2.0;

    return out;
}

float4 texture(texture2d<half> texture, float2 pos)
{
    constexpr sampler texture_sampler;
    return pow(float4(texture.sample(texture_sampler, pos)), GAMMA);
}

float4 texture_relative(texture2d<half> t, float2 pos, float2 offset)
{
    float2 input_resolution = float2(t.get_width(), t.get_height());;
    float2 origin = (floor(pos * input_resolution)) + float2(0.5, 0.5);
    return texture(t, (origin + offset) / input_resolution);
}
