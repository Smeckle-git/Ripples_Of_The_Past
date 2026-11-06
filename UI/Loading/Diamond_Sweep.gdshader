// Adapted from the first game's "diamon sweep.gdshader".
shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float diamond_size = 40.0;

void fragment() {
	float x = abs(fract(FRAGCOORD.x / diamond_size) - 0.5);
	float y = abs(fract(FRAGCOORD.y / diamond_size) - 0.5);
	if (x + y + UV.x > progress * 2.0) {
		discard;
	}
}
