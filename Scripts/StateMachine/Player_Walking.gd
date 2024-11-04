extends Player_State
class_name PlayerWalking
	
func Update(_delta:float):
	if Input.get_axis("ui_left", "ui_right") == 0.0 and Input.get_axis("ui_up", "ui_down") == 0.0:
		state_transition.emit("idle")

func Physics_Update(_delta: float):
	if target:
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (target.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		if direction.length() > 0:
			target.velocity = direction * speed
		
