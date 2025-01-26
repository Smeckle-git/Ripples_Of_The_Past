extends Player_State
class_name PlayerFollow

func Physics_Update(_delta: float):
	if target:
		var direction = state_machine.follow_target.global_position - target.global_position
		if direction.length() > 1:
			target.velocity = Vector3(direction.x * 4, -4.5, direction.z * 4)
		else:
			target.velocity = Vector3(0,0,0)
		
