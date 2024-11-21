extends StaticBody3D
class_name Campfire

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@export var noise: NoiseTexture3D
@onready var omni_light_3d: OmniLight3D = $AnimatedSprite3D2/AnimatedSprite3D/OmniLight3D
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var animated_sprite_3d_2: AnimatedSprite3D = $AnimatedSprite3D2

@export var campfire_on := true
@export var campfire_extinguished := false

var time_passed := 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if campfire_on:
		animated_sprite_3d_2.visible = true
		time_passed += delta
		var noise_sample = noise.noise.get_noise_1d(time_passed)
		omni_light_3d.light_energy = 1 + abs(noise_sample) * 4
	else :
		animated_sprite_3d_2.visible = false
		omni_light_3d.light_energy = 0
	
	if campfire_extinguished:
		sprite_3d.frame = 1
	else :
		sprite_3d.frame = 0
