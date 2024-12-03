shader_type spatial;
render_mode cull_disabled;

uniform vec3 base_color: source_color;
uniform vec3 inside_color: source_color;
uniform float disolve_amount: hint_range(0.0, 1.0) = 0.0;

uniform sampler2D noise_texture;

uniform vec3 glow_color: source_color = vec3(1.0,0.0,0.0);
uniform float glow_intensity = 5.0;
uniform float glow_border_wit: hint_range(0.0, 0.25) = 0.05;
uniform float glow_border_smoothness: hint_range(0.0, 0.1) = 0.04;

void fragment() {
	float disolve_noise = texture(noise_texture,UV).r;

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

	vec3 surface_color = mix(base_color, vec3(0.0), border_mask); // color of outside

	if(!FRONT_FACING){
		surface_color = inside_color;
	}



	ALBEDO = surface_color;

	EMISSION = surface_emmision * glow_intensity;
	ALPHA = disolve_noise;
	ALPHA_SCISSOR_THRESHOLD = disolve_amount;
}
