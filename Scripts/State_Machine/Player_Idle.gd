extends PlayerState
class_name PlayerIdle

func Enter():
	if target:
		target.velocity = Vector3(0, 0, 0)

func Update(_delta:float):
	if Dialogic.current_timeline:
		state_transition.emit("PlayerDialogue")
	elif Input.get_axis("move_left", "move_right") or Input.get_axis("move_forward", "move_backward"):
		state_transition.emit("PlayerWalking")
