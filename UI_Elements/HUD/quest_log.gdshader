shader_type canvas_item;

uniform vec4 color: source_color = vec4(0);
void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	
	COLOR = vec4(input_color.r * color.r, input_color.g * color.g, input_color.b * color.b, input_color.a * color.a);
}
