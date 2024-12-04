extends CharacterBody3D
class_name Companion

@onready var thorinn: CharacterBody3D = $"../Thorinn"
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var interaction_area: InteractionArea = $InteractionArea2
@onready var area_3d: CollisionShape3D = $InteractionArea2/Area3D
@onready var timer: Timer = $Timer

const SPEED = 10.0
@export var following := false
@export var sitting = false

@export var move_to_location : Vector3 = Vector3(0,0,0)	


func _physics_process(delta: float) -> void:
	manage_animations()
	move_and_slide()	
	var direction
	if following:
		direction = thorinn.global_position - global_position
		
		if direction.length() > 6:
			velocity = direction.normalized() * SPEED
			sitting = false
		elif direction.length() > 1:
			velocity = direction.normalized() * SPEED / 2
			sitting = false
		else:
			velocity = Vector3(0,0,0)

	elif move_to_location != Vector3(0,0,0):
		direction = move_to_location - position
		velocity = direction.normalized() * SPEED / 3
		if direction.length() <= 0.5:
			move_to_location = Vector3(0,0,0)
			last_direction = Vector2(0,1)
			velocity = Vector3(0,0,0)
	
	if velocity == Vector3.ZERO:
		if timer.is_stopped():
			timer.start()
	else:
		timer.stop()



@export var last_direction := Vector2(0, 1)
func manage_animations():	
	if velocity != Vector3.ZERO:
		last_direction = Vector2(velocity.x, velocity.z)
	
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walking/blend_position", last_direction)
	animation_tree.set("parameters/Sitting/blend_position", last_direction)


func _on_timer_timeout() -> void:
	sitting = true
