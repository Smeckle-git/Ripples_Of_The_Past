extends CharacterBody3D
class_name Companion

@onready var thorinn: CharacterBody3D = $"../Thorinn"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var timer: Timer = $Timer
@onready var interaction_area: InteractionArea = $InteractionArea2
@onready var pet_cat_animation: AnimatedSprite3D = $Node3D_pet_cat/AnimatedSprite3D

const SPEED = 10.0
@export var following := false
@export var sitting = false

@export var move_to_location : Vector3 = Vector3(0,0,0)	
#
var petting: bool = false
#
func _physics_process(_delta: float) -> void:
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

func _on_interact() -> void:
	print_debug("Whiskers interacted")
	pet_cat()
	#pass

func pet_cat() -> void:
	if petting:
		print_debug("pat pat pat")
		return
	#
	print_debug("pat cat")
	petting = true
	var random: int = randi_range(0, pet_cat_animation.sprite_frames.get_frame_count("default"))
	pet_cat_animation.frame = random
	pet_cat_animation.visible = true
	await get_tree().create_timer(3).timeout
	pet_cat_animation.visible = false
	petting = false
	print_debug("no pat cat")
	#pass
