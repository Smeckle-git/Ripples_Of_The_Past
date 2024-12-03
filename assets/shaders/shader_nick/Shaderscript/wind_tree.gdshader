shader_type spatial;
render_mode cull_disabled;
uniform sampler2D sprite;

uniform float WindStrength: hint_range(0.0, 5.0) = 3.0;
uniform float speed: hint_range(1.0, 5.0) = 2.0;

void vertex() {
	float vec_scaler = (1.0  - UV.y) * WindStrength;
	float time = TIME * speed;
	float vec_full = vec_scaler * sin(time + VERTEX.x);
	float decompose = VERTEX.x + vec_full;
	vec2 combine = vec2(decompose, VERTEX.y);
	VERTEX.xy = combine;
}

void fragment() {
	vec4 image = texture(sprite, UV);
	ALBEDO = image.rgb;
	ALPHA = image.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
