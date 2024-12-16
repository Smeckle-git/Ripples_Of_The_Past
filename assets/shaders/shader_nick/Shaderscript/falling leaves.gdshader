shader_type spatial;
render_mode cull_disabled;
uniform sampler2D texture_2d;
//https://www.youtube.com/watch?v=jMahvQMoXfE&t=140s&ab_channel=CrowGames
void vertex() {

}

void fragment() {
	vec4 text2d = texture(texture_2d, UV);
	ALBEDO = text2d.rgb;
	ALPHA = text2d.a;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
