extends PlayerState
class_name Walking
@onready var States = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(States.player)
	#animation_player.play("Walking_A")
	print("in idle state")
	pass # Replace with function body.

#func _physics_process(delta: float) -> void:
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#player.velocity.x = direction.x * SPEED
		#player.velocity.z = direction.z * SPEED
	#else:
		#player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		#player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
#
	#player.move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
