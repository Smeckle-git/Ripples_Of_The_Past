extends Node

@onready var pause_menu : MarginContainer = $PauseMenu
@onready var level: Node3D = $Level

var level1 = true




func _process(delta: float) -> void:
	# pause logic
	
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()


func pauseMenu() -> void:
	if get_tree().paused:
		pause_menu.hide()
		get_tree().paused = !get_tree().paused
	else:
		pause_menu.show()
		get_tree().paused = !get_tree().paused

func currentMap():
	var temp = self.get_children()
	for n in temp:
		if n.name == level.name:
			level1 = true
		else:
			level1 = false
