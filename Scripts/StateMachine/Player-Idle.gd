extends Player_State
class_name player_Idle

func Enter():
	if target:
		target.velocity = Vector3(0, 0, 0)

func Update(_delta:float):
	if Input.get_axis("ui_left", "ui_right") or Input.get_axis("ui_up", "ui_down"):
		state_transition.emit("walking")
