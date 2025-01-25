extends Player_State
class_name PlayerWalking
	
@onready var walking_sound: AudioStreamPlayer2D = $"../../Walking Sound"

func Enter():
	if not walking_sound.playing:
		walking_sound.play() 

func Update(_delta:float):
	if not target.is_on_floor():
		state_transition.emit("falling")
	elif Dialogic.current_timeline:
		state_transition.emit("dialogue")
	elif Input.get_axis("Walk left", "Walk right") == 0.0 and Input.get_axis("Walk forward", "Walk backwards") == 0.0:
		state_transition.emit("idle")
	if not walking_sound.playing:
		walking_sound.play() 

func Physics_Update(_delta: float):
	if target:
		var input_dir := Input.get_vector("Walk left", "Walk right", "Walk forward", "Walk backwards")
		var direction = (target.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		if direction.length() > 0:
			target.velocity = direction * speed

func Exit():
	walking_sound.stop()
