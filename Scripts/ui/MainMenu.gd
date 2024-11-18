extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_divide_Slice/MainContainer/CenterContainer/ChoiceContainer/ContinueGame.grab_focus()

func _on_continue_game_pressed() -> void:
	print("Load SaveFile / Begin Game")
	get_tree().change_scene_to_file("res://scenes/Levels/Demo/Game.tscn")
	


func _on_new_game_pressed() -> void:
	print("Begin a new Game")
	get_tree().change_scene_to_file("res://scenes/Levels/Demo/Game.tscn")
	
func _on_settings_pressed() -> void:
	print("Opens The Settings Scene")
	get_tree().change_scene_to_file("res://scenes/Levels/Demo/Game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
