extends MarginContainer
#
@export var loading_screen: PackedScene
#
@onready var continue_game: Button = $HBoxContainer/MenuContainer/MainContainer/ChoiceContainer/NewGame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continue_game.grab_focus()


func _on_continue_game_pressed() -> void:
	print("Load SaveFile / Begin Game")
	get_tree().change_scene_to_file("res://Levels/Demo/Game.tscn")
	#get_tree().call_deferred("change_scene_to_packed", loading_screen)

func _on_new_game_pressed() -> void:
	print("Begin a new Game")
	get_tree().change_scene_to_file("res://scenes/Levels/Game.tscn")#CHANGEEEEEEEEEEEE
	#get_tree().change_scene_to_file("res://scenes/Levels/Intro.tscn")

func _on_settings_pressed() -> void:
	print("Opens The Settings Scene")
	get_tree().change_scene_to_file("res://scenes/ui/SettingMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
