shader_type spatial;
//render_mode
	//repeat_enable;

uniform sampler2D erosion;
uniform vec4 texture_albedo: source_color;
uniform vec2 tiling = vec2(1.0,1.0);
uniform vec2 offset;
uniform float erosion_offset;

void vertex() {
	UV = UV * tiling + offset * TIME;
}

void fragment() {
	vec2 base_uv = UV;

	//vec4 albedo_tex = texture(texture_albedo, base_uv);
	float erosion_tex = texture(erosion,UV).r;
	float erosion_min = 0.4;
	float erosion_max = erosion_min + erosion_offset;
	float erosion_val = smoothstep(erosion_min, erosion_max, erosion_tex);
	//(sin(TIME * 0.5) + 2.0)* 0.5; use for eas in and out

	//ALPHA *= albedo.a * albdedo_text.a;
	ALBEDO = texture_albedo.rgb;
	ALPHA = erosion_val;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
