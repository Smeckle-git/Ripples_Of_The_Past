extends Player_State
class_name player_Dialogue

func Enter():
	if target:
		target.velocity = Vector3(0, 0, 0)

func Update(_delta:float):
	if Dialogic.current_timeline == null:
		state_transition.emit("idle")
