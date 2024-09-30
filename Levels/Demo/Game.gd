extends Node

@onready var pause_menu : MarginContainer = $PauseMenu


func _ready() -> void:
	print_debug(get_tree())

func _process(delta: float) -> void:
	# pause logic
	if Input.is_action_just_pressed("ui_cancel"):
		pauseMenu()


func pauseMenu() -> void:
	if get_tree().paused:
		pause_menu.hide()
		get_tree().paused = !get_tree().paused
	else:
		pause_menu.show()
		get_tree().paused = !get_tree().paused
