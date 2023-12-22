//
//  MetalShared.h
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#ifndef MetalShared_h
#define MetalShared_h

#include <metal_stdlib>
#include <simd/simd.h>
#include <metal_math>

using namespace metal;

/* For GLSL compatibility */
typedef float2 vec2;
typedef float3 vec3;
typedef float4 vec4;
typedef texture2d<half> sampler2D;
#define equal(x, y) all((x) == (y))
#define inequal(x, y) any((x) != (y))
#define STATIC static
#define GAMMA (2.2)
#define BLEND_BIAS (2.0/5.0)

typedef struct {
    float4 position [[position]];
    float2 texcoords;
} rasterizer_data;

enum frame_blending_mode {
    DISABLED,
    SIMPLE,
    ACCURATE,
    ACCURATE_EVEN = ACCURATE,
    ACCURATE_ODD,
};

float4 texture(texture2d<half> texture, float2 pos);
float4 texture_relative(texture2d<half> t, float2 pos, float2 offset);

#endif /* MetalShared_h */
