//
//  BaseFragment.h
//  SameBoy
//
//  Created by C.W. Betts on 12/22/23.
//

#ifndef BaseVertex_h
#define BaseVertex_h

fragment float4 fragment_shader(rasterizer_data in [[stage_in]],
                                texture2d<half> image [[ texture(0) ]],
                                texture2d<half> previous_image [[ texture(1) ]],
                                constant enum frame_blending_mode *frame_blending_mode [[ buffer(0) ]],
                                constant float2 *output_resolution [[ buffer(1) ]])
{
    float2 input_resolution = float2(image.get_width(), image.get_height());

    in.texcoords.y = 1 - in.texcoords.y;
    float ratio;
    switch (*frame_blending_mode) {
        default:
        case DISABLED:
            return pow(scale(image, in.texcoords, input_resolution, *output_resolution), 1 / GAMMA);
        case SIMPLE:
            ratio = 0.5;
            break;
        case ACCURATE_EVEN:
            if (((int)(in.texcoords.y * input_resolution.y) & 1) == 0) {
                ratio = BLEND_BIAS;
            }
            else {
                ratio = 1 - BLEND_BIAS;
            }
            break;
        case ACCURATE_ODD:
            if (((int)(in.texcoords.y * input_resolution.y) & 1) == 0) {
                ratio = 1 - BLEND_BIAS;
            }
            else {
                ratio = BLEND_BIAS;
            }
            break;
    }
    
    return pow(mix(scale(image, in.texcoords, input_resolution, *output_resolution),
               scale(previous_image, in.texcoords, input_resolution, *output_resolution), ratio), 1 / GAMMA);
}

#endif /* BaseVertex_h */
