# idle.gd
extends State
class_name Idle

@onready var state_machine = get_parent()


func Enter():
	if state_machine.sprite:
		state_machine.sprite.play("idle-up")
	else:
		print("Error: sprite is null")

func Update(_delta: float):
	var player = state_machine.player
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction.length() > 0:
		state_transition.emit(self, "walking")  # Transition to walking state

func Exit():
	# Any cleanup when exiting the Idle state can be done here
	pass
