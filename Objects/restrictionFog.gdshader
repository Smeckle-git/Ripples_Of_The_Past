shader_type fog;

uniform sampler2D noise_texture:repeat_enable;
uniform float noise_scale = 1.0;

void fog() {
	vec2 movement = vec2(0.05, 0.0) * TIME;
	float noise = texture(noise_texture, WORLD_POSITION.z * noise_scale + movement).r;
	DENSITY = noise - 0.2;
	//DENSITY = step(0.0, sdf);
	ALBEDO = vec3(1,0.8,0.8);
	// Called once for every froxel that is touched by an axis-aligned bounding box
	// of the associated FogVolume. This means that froxels that just barely touch
	// a given FogVolume will still be used.
}
