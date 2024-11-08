extends CharacterBody3D
@onready var companion: CharacterBody3D = $"."
@onready var thorinn: CharacterBody3D = $"../Thorinn"
@onready var animation_tree: AnimationTree = $AnimationTree



const SPEED = 10.0

func _physics_process(delta: float) -> void:
	manage_animations()
	move_and_slide()
	var direction = thorinn.global_position - companion.global_position
	
	#print(direction.length())
	if direction.length() > 6:
		companion.velocity = direction.normalized() * SPEED
	elif direction.length() > 1:
		companion.velocity = direction.normalized() * SPEED / 2
	else:
		companion.velocity = Vector3(0,0,0)



var last_direction := Vector2(0, 1)
func manage_animations():	
	if velocity != Vector3.ZERO:
		last_direction = Vector2(velocity.x, velocity.z)
	
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walking/blend_position", last_direction)
