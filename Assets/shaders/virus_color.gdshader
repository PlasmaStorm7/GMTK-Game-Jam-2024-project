shader_type spatial;

uniform vec4 color0;
uniform vec4 color1;
uniform vec4 color2;
uniform vec4 color3;
varying vec3 colorAlbedo;

void vertex() {
    if (VERTEX.x > 0.0)
        colorAlbedo = (VERTEX.y > 0.0) ? color0.rgb : color1.rgb;
    else
        colorAlbedo = (VERTEX.y > 0.0) ? color2.rgb : color3.rgb;
}

void fragment() {
    float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
    RIM = 0.2;
    METALLIC = 0.0;
    ROUGHNESS = 0.01 * (1.0 - fresnel);
    ALBEDO = colorAlbedo.rgb;
}

// void light() {
// }
