shader_type spatial;
render_mode blend_add;

uniform sampler2D text;
uniform float horizontalFrames = 3.0;
uniform float verticalFrames = 5.0;
uniform float  tracks: hint_range(0.0, 1, 0.2);
varying float phase;
varying float track;

void vertex() {
	mat4 globalMatrix = mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], MODEL_MATRIX[2],MODEL_MATRIX[3]);
	MODELVIEW_MATRIX = VIEW_MATRIX * globalMatrix;

	phase = INSTANCE_CUSTOM.y;
	//track = float(INSTANCE_ID % int(verticalFrames));
	// Called for every vertex the material is visible on.
}

void fragment() {
	float frameNumber = floor(phase * horizontalFrames)/ horizontalFrames;
	//float trackNumber = track/ verticalFrames;

	vec2 UVscaler = vec2(1.0/ horizontalFrames, 1.0/ verticalFrames);
	vec2 UVshifter = vec2(frameNumber, tracks);
	vec4 colour = texture(text,UV * UVscaler + UVshifter );
	ALBEDO = vec3(0);
	EMISSION = colour.rgb;
	//ALPHA = colour.a;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
