shader_type canvas_item;

uniform vec4 color: source_color;

const float speed = 700.0;
const float duration = 3.0;
const float width = 10.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	vec2 position = SCREEN_UV / SCREEN_PIXEL_SIZE;
	
	vec4 texture_color = texture(TEXTURE, UV);
	
	float dist = abs(
		position.x +
		position.y +
		mod(TIME * speed, duration * speed) - duration * speed * 0.5f
	);
	
	if (dist <= width && texture_color.a > 0.0) {
		float intensity = 1.0 - smoothstep(0.0, width, dist);
		COLOR += color * texture_color.a * intensity;
	}
}

