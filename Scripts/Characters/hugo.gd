extends CharacterBody3D
class_name Hugo

const SPEED = 4.0
@export var move_to_location : Array = []
@onready var interaction_area: InteractionArea = $InteractionArea2
@onready var animation_tree: AnimationTree = $AnimationTree

signal destination_reached

func _physics_process(delta: float) -> void:
	manage_animations()
	move_and_slide()
	
	if move_to_location.size() > 0:
		var current_target = move_to_location[0]
		var direction = Vector3(current_target.x - position.x,0,current_target.z - position.z)
		velocity.x = direction.normalized().x * SPEED
		velocity.z = direction.normalized().z * SPEED
		velocity.y = -0.01

		if direction.length() <= 0.1:
			move_to_location.pop_front()
			velocity = Vector3.ZERO
		
		if move_to_location.size() == 0:
			emit_signal("destination_reached")
		
	else:
		velocity = Vector3.ZERO


@export var last_direction := Vector2(0, 1)
func manage_animations():	
	if velocity != Vector3.ZERO:
		last_direction = Vector2(velocity.x, velocity.z)
	
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walking/blend_position", last_direction)
	animation_tree.set("parameters/Sitting/blend_position", last_direction)
