extends PlayerState
class_name PlayerWalking

func Update(_delta:float):
	if not target.is_on_floor():
		state_transition.emit("PlayerFalling")
	elif Dialogic.current_timeline:
		state_transition.emit("PlayerDialogue")
	elif Input.get_axis("move_left", "move_right") == 0.0 and Input.get_axis("move_forward", "move_backward") == 0.0:
		state_transition.emit("PlayerIdle")

func Physics_Update(_delta: float):
	if target:
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction = (target.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		if direction.length() > 0:
			target.velocity = direction * speed
