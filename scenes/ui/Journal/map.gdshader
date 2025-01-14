shader_type canvas_item;

uniform sampler2D texture : source_color;
uniform vec3 recolor : source_color = vec3(1.0, 0.0, 0.0); // Red color for interior
uniform float threshold : hint_range(0.0, 1.0) = 0.1; // Transparency threshold

void fragment() {
    // Get the color of the current pixel from the texture
    vec4 tex_color = texture(texture, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
    
    // If the pixel is not transparent (based on threshold)
    if (tex_color.a > threshold) {
        // Recolor the interior with the specified color
        tex_color.rgb = recolor;
    }
    
    // Set the final color of the fragment
    COLOR = tex_color;
}