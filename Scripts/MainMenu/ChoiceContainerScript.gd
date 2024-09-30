extends VBoxContainer

@export var SettingsScene : PackedScene
@export var NewGameScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ContinueGame.grab_focus()



func _on_continue_game_pressed() -> void:
	print("Load SaveFile / Begin Game")
	get_tree().change_scene_to_packed(NewGameScene)
	


func _on_new_game_pressed() -> void:
	print("Begin a new Game")
	$"../../../..".visible = false  # Hide the main menu but don't unload it
	var game_scene = NewGameScene.instantiate()
	get_tree().root.add_child(game_scene)  # Add the game scene to the scene tree
	


func _on_settings_pressed() -> void:
	print("Opens The Settings Scene")
	get_tree().change_scene_to_packed(SettingsScene)


func _on_quit_pressed() -> void:
	get_tree().quit()
