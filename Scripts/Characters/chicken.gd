extends CharacterBody3D
class_name Kip

@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var timer: Timer = $Timer

var wandering = false
var target_position: Vector3 = Vector3.ZERO

const corner1 = Vector2(11, 28)
const corner2 = Vector2(18, 49)

func _ready() -> void:
	choose_next_target()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = -3
	elif wandering:
		var direction = (target_position - global_position).normalized()
		if global_position.distance_to(target_position) > 0.1:
			velocity = direction * 3
		else:
			velocity = Vector3.ZERO
			wandering = false
			timer.start()
	else:
		velocity = Vector3.ZERO
	
	manage_animations()
	move_and_slide()

func _on_timer_timeout() -> void:
	choose_next_target()
	wandering = true

func choose_next_target() -> void:
	var random_x = randf_range(corner1.x, corner2.x)
	var random_z = randf_range(corner1.y, corner2.y)
	target_position = Vector3(random_x, global_position.y, random_z)
	print("New target position:", target_position)

func manage_animations():
	var move_speed = velocity.length()
	
	if move_speed > 0.1:
		animated_sprite_3d.play("Walking")
		animated_sprite_3d.flip_h = velocity.z < 0
	else:
		animated_sprite_3d.play("Idle")
