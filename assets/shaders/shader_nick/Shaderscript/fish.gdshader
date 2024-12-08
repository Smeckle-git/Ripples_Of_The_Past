shader_type spatial;
uniform sampler2D text;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture_2d = texture(text, UV);
	ALBEDO = texture_2d.rgb;
	ALPHA = texture_2d.a;
}
