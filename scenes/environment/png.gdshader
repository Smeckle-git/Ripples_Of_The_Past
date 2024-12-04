shader_type spatial;

uniform sampler2D texture_albedo;
render_mode cull_disabled;

void fragment() {
	vec4 tex_color = texture(texture_albedo, UV);
	ALBEDO = tex_color.rgb;
	ALPHA = tex_color.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
