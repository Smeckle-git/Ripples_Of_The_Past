extends Node

@onready var pause_menu : MarginContainer = $PauseMenu
@onready var level: Node3D = $Level

func _process(delta: float) -> void:
	pass

	#if Input.is_action_just_pressed("Pause"):
		#pauseMenu()


func pauseMenu() -> void:
	if get_tree().paused:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
