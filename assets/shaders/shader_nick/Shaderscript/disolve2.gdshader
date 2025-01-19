shader_type spatial;
render_mode cull_disabled;
group_uniforms Texture;
uniform sampler2D text2d;

group_uniforms Colors;
uniform vec3 base_color: source_color;
uniform vec3 inside_color: source_color;

group_uniforms Disolve;
uniform float disolve_amount: hint_range(0.01, 1.0) = 0.0;
uniform sampler2D noise_texture;

group_uniforms Glow;
uniform vec3 glow_color: source_color = vec3(1.0,0.0,0.0);
uniform float glow_intensity = 5.0;
uniform float glow_border_wit: hint_range(0.0, 0.25) = 0.05;
uniform float glow_border_smoothness: hint_range(0.0, 0.1) = 0.04;

void vertex(){
		mat4 n_out7p0;
	{
		mat4 __mvm = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], MODEL_MATRIX[1], vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, MODEL_MATRIX[1].xyz)), 0.0), MODEL_MATRIX[3]);
		__mvm = __mvm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		n_out7p0 = __mvm;
	}
	MODELVIEW_MATRIX = n_out7p0;f
}


void fragment() {
	//textureGather()
	float disolve_noise = texture(noise_texture,UV).r;
	vec4 texture_2d = texture(text2d,UV);
	float border_mask = 0.0;
	float new_amount = clamp(disolve_amount, 0.1, 1.0); // thicknes of disolve border + disolve self
	float border_size = new_amount + glow_border_wit;

	// make smoothstep with the disolve and border and put it on mask
	border_mask = 1.0 -  smoothstep(
		border_size - glow_border_smoothness,
		border_size + glow_border_smoothness,
		disolve_noise
	);

	vec3 surface_emmision = mix(vec3(0.0), glow_color, border_mask); // glow/border color of disolve

	vec3 surface_color = mix(NORMAL_MAP.rgb, vec3(0.0), border_mask); // color of outside

	if(!FRONT_FACING){
		surface_color = inside_color;
	}



	ALBEDO = surface_color;

	EMISSION = surface_emmision * glow_intensity;
	ALPHA = disolve_noise * texture_2d.a;
	ALPHA_SCISSOR_THRESHOLD = disolve_amount;
}
