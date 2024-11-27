extends Player_State
class_name PlayerWalking
	
func Update(_delta:float):
	if not target.is_on_floor():
		state_transition.emit("falling")
	elif Input.get_axis("Walk left", "Walk right") == 0.0 and Input.get_axis("Walk forward", "Walk backwards") == 0.0:
		state_transition.emit("idle")

func Physics_Update(_delta: float):
	if target:
		var input_dir := Input.get_vector("Walk left", "Walk right", "Walk forward", "Walk backwards")
		var direction = (target.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		if direction.length() > 0:
			target.velocity = direction * speed
		
