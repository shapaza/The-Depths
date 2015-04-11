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

void main()
{
    float scalar;
    float dist = distance(v_vPos.xy, v_vLampPos);
    
    if (dist < lamp_radius) {
        scalar = 1.0- 0.95*(dist/lamp_radius);    
    }
    else
        scalar = 0.05;
        
    gl_FragColor = vec4(scalar, scalar, scalar, 1.0) * v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}

