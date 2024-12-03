extends Player_State
class_name player_Idle

func Enter():
	if target:
		target.velocity = Vector3(0, 0, 0)

func Update(_delta:float):
	if Input.get_axis("Walk left", "Walk right") or Input.get_axis("Walk forward", "Walk backwards"):
		state_transition.emit("walking")
