extends PlayerState
class_name PlayerFalling
	
func Update(_delta:float):
	if target.is_on_floor():
		state_transition.emit("PlayerIdle")

func Physics_Update(_delta: float):
	if target:
		target.velocity.y = target.velocity.y - 20
		
