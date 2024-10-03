# walking.gd
extends State
class_name Walking

const SPEED = 5.0

@onready var state_machine = get_parent()

func Enter():
	state_machine.sprite.play("walking-up")

func Update(_delta: float):
	var player = state_machine.player
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction.length() == 0:
		state_transition.emit(self, "idle")  # Transition to idle state

func Physics_Update(_delta: float):
	var player = state_machine.player
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction.length() > 0:
		player.velocity = direction * SPEED  # Set the character's velocity
	else:
		player.velocity = Vector3.ZERO  # Stop the character when there's no input

	player.move_and_slide()  # Move the character
