extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		# Determine animation based on direction
		if abs(direction.x) > abs(direction.z):  # Left or Right
			if direction.x > 0:
				animated_sprite.play("walking-right")
			else:
				animated_sprite.play("walking-left")
		else:  # Up or Down
			if direction.z > 0:
				animated_sprite.play("walking-down")
			else:
				animated_sprite.play("walking-up")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		# Check for idle animation
		if animated_sprite.animation.begins_with("walking-"):
			# Determine idle animation based on last direction
			if animated_sprite.animation == "walking-right":
				animated_sprite.play("idle-right")
			elif animated_sprite.animation == "walking-left":
				animated_sprite.play("idle-left")
			elif animated_sprite.animation == "walking-down":
				animated_sprite.play("idle-down")
			elif animated_sprite.animation == "walking-up":
				animated_sprite.play("idle-up")

	move_and_slide()
