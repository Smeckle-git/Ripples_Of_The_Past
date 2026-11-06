extends PlayerState
class_name PlayerDialogue

func Enter():
	if target:
		target.velocity = Vector3.ZERO

func Update(_delta: float):
	if Dialogic.current_timeline == null:
		state_transition.emit("PlayerIdle")
