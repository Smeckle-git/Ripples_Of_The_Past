shader_type spatial;
render_mode unshaded;
uniform sampler2D texture2d;
void vertex() {
//	 got from virtual coding is setting bilboard to y
	mat4 n_out7p0;
	{
		mat4 __mvm = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], MODEL_MATRIX[1], vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, MODEL_MATRIX[1].xyz)), 0.0), MODEL_MATRIX[3]);
		__mvm = __mvm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		n_out7p0 = __mvm;
	}
	MODELVIEW_MATRIX = n_out7p0;
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 text2d = texture(texture2d,UV);
	vec4 test = COLOR;
	ALBEDO = test.rgb;
	ALPHA = text2d.r * test.a;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
