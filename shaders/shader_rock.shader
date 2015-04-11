//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPos;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vPos = gm_Matrices[MATRIX_WORLD] * object_space_pos;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vPos;

uniform vec2 v_vLampPos;
uniform float lamp_radius;

uniform float light_x_array[20];
uniform float light_y_array[20];
uniform float light_rad_array[20];

uniform int num_lights;

void main()
{
    int i = 0;
    float scalar = 0.05;
    float dist;
    vec2 light_pos;
    
    for (i = 0; i < num_lights; i++) {
        light_pos = vec2(light_x_array[i], light_y_array[i]);   
        dist = distance(light_pos, v_vPos.xy);
    
        if (dist < light_rad_array[i]) {
            scalar += 1.0- 0.95*(dist/light_rad_array[i]);
            
            if (scalar > 1.0)
                scalar = 1.0;    
        }
    }
        
    gl_FragColor = vec4(scalar, scalar, scalar, 1.0) * v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}

