extends StaticBody3D

@export var camera : Camera3D
@onready var hitbox : CollisionShape3D = $CollisionShape3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var Camera_position = camera.global_position
	hitbox.look_at(Camera_position)
