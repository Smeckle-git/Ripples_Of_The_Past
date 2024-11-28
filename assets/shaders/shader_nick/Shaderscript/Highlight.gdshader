shader_type spatial;
//render_mode cull_back;
uniform sampler2D texture2d;
uniform vec4 color_test: source_color;

//uniform float offset = 1.0;
//varying vec2 uv_timer;
vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}

void vertex() {
	//uv_timer = UV * offset * TIME;

}

void fragment() {
	vec4 text2d = texture(texture2d, UV);
	vec3 fresnel = fresnel_glow(3.0, 4.5, color_test.rgb, NORMAL, VIEW );
	ALBEDO = text2d.rgb * fresnel;

	//ALBEDO = text2d.rgb * color_test.rgb;
	ALPHA = text2d.a * color_test.a ;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
