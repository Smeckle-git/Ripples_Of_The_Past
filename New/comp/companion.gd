extends CharacterBody3D
@onready var companion: CharacterBody3D = $"."
@onready var thorinn: CharacterBody3D = $"../Thorinn"

const SPEED = 10.0

func _physics_process(delta: float) -> void:
	move_and_slide()
	var direction = thorinn.global_position - companion.global_position
	
	print(direction.length())
	if direction.length() > 6:
		companion.velocity = direction.normalized() * SPEED
	elif direction.length() > 2:
		companion.velocity = direction.normalized() * SPEED / 2
	else:
		companion.velocity = Vector3(0,0,0)
