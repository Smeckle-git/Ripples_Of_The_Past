shader_type spatial;
uniform vec3 color: source_color;
uniform vec3 color2 : source_color;
uniform float metallic: hint_range(0.0, 1.0) = 0.0;
uniform float roughness: hint_range(0.0, 1.0) = 0.02;

uniform sampler2D noise_text1;
uniform sampler2D noise_text2;

uniform vec2 wave_direction_1 = vec2(2.0,0.0) ;
uniform vec2 wave_direction_2 = vec2(0.0,1.1) ;
uniform float speed_waves : hint_range(0.0, 0.2, 0.005) = 0.025;

uniform sampler2D wave;
uniform float noise_scale = 10.0;
uniform float height_scale = 0.15;

uniform vec4 color_deep : source_color;
uniform vec4 color_shallow : source_color;
uniform float beers_law = 2.0;
uniform float depth_offset = -0.75;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


varying float height;
varying vec3 world_pos;

float fresnel(float amount, vec3 normal, vec3 view){
	return pow((1.0 - clamp(dot(normalize(normal),normalize(view)),0.0, 1.0)),amount);
}


//https://www.youtube.com/watch?v=7L6ZUYj1hs8&ab_channel=StayAtHomeDev
void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	height = texture(wave, world_pos.xz / noise_scale + TIME * speed_waves).r;
	VERTEX.y += height * height_scale;
}

void fragment() {
	float depth_texture = texture(DEPTH_TEXTURE, SCREEN_UV).r * 2.0 - 1.0;
	float depth = PROJECTION_MATRIX[3][2] / (depth_texture + PROJECTION_MATRIX[2][2]);
	float depth_blend = exp((depth+VERTEX.z + depth_offset) * -beers_law);
	depth_blend = clamp(1.0 - depth_blend, 0.0, 1.0);	
	float depth_blend_power = clamp(pow(depth_blend, 2.5), 0.0, 1.0);

	vec3 screen_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, depth_blend_power * 2.5).rgb;
	vec3 depth_color = mix(color_shallow.rgb, color_deep.rgb, depth_blend_power);
	vec3 new_color = mix(screen_color * depth_color, depth_color * 0.25, depth_blend_power * 0.5);
	
	
	vec2 movement1 = (TIME * wave_direction_1) * speed_waves;
	vec2 movement2 = (TIME * wave_direction_2) * speed_waves;
	
	vec3 noise_mix = mix(texture(noise_text1,world_pos.xz + movement2).rgb, texture(noise_text2,world_pos.xz + movement1).rgb, 0.5);
	
	float fresnel = fresnel(5.0, NORMAL, VIEW);
	vec3 surface_color = mix(color, color2, fresnel);

	
	
	ALBEDO =  mix(surface_color, new_color, 0.75);
	METALLIC = metallic;
	ROUGHNESS = roughness;
	NORMAL_MAP = noise_mix;

	// Called for every pixel the material is visible on.
}
