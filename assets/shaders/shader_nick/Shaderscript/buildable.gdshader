shader_type spatial;
uniform sampler2D textur2d;
uniform vec4 scanline_color: source_color;
uniform float scanline_scroll_speed;
uniform float scanline_scale;

uniform float fresnel_power;
uniform vec4 fresnel_color: source_color;
//https://www.youtube.com/watch?v=ECVahTzDw4U&list=PLUEN4fiW_O1Vx58z1MReaiacsZIUR7dxW&ab_channel=GabrielAguiarProd.
varying vec3 worldPos;

void vertex() {
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	float scanline_speed_time = scanline_scroll_speed * TIME;
	float scanline_lines = worldPos.y * scanline_scale;
	float scanline_animation = scanline_lines + scanline_speed_time;

//	move the texture
	vec2 compose = vec2(0.0,scanline_animation);
	vec4 text2d = texture(textur2d, compose);

	float fresnel = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), fresnel_power);
	vec4 fresnel_compleet = vec4(fresnel) * fresnel_color;
	vec4 scanline_compleet = scanline_color * text2d;
	vec4 compleet = scanline_compleet + fresnel_compleet;

	ALPHA = (scanline_color.a * text2d.a) + fresnel_compleet.a;
	EMISSION = compleet.xyz ;
}
