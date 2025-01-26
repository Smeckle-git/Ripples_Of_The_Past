shader_type spatial;
uniform sampler2D texture_2d;
//https://www.youtube.com/watch?v=jMahvQMoXfE&t=140s&ab_channel=CrowGames
void vertex() {
	mat4 n_out7p0;
	{
		mat4 __mvm = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], MODEL_MATRIX[1], vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, MODEL_MATRIX[1].xyz)), 0.0), MODEL_MATRIX[3]);
		__mvm = __mvm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		n_out7p0 = __mvm;
	}
	MODELVIEW_MATRIX = n_out7p0;
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
