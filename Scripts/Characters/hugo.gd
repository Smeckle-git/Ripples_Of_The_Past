extends CharacterBody3D


const SPEED = 10.0
@export var move_to_location : Vector3 = Vector3(0,0,0)
@onready var interaction_area: InteractionArea = $InteractionArea2
@onready var animation_tree: AnimationTree = $AnimationTree

func _physics_process(delta: float) -> void:
	manage_animations()
	move_and_slide()	
	
	var direction
	if move_to_location != Vector3(0,0,0):
		direction = move_to_location - position
		velocity = direction.normalized() * SPEED / 3
		if direction.length() <= 0.5:
			move_to_location = Vector3(0,0,0)
			last_direction = Vector2(0,1)
			velocity = Vector3(0,0,0)


@export var last_direction := Vector2(0, 1)
func manage_animations():	
	if velocity != Vector3.ZERO:
		last_direction = Vector2(velocity.x, velocity.z)
	
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walking/blend_position", last_direction)
	animation_tree.set("parameters/Sitting/blend_position", last_direction)
