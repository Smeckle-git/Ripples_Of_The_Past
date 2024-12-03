shader_type spatial;
uniform sampler2D text2d;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 img = texture(text2d, UV);
	ALBEDO = img.rgb;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
