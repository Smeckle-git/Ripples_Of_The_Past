extends Control

@onready var continue_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/ContignueGame

func _ready() -> void:
	continue_button.disabled = not SaveManager.has_save()

func _on_contignue_game_pressed() -> void:
	pass

func _on_new_game_pressed() -> void:
	if TransitionManager.is_transitioning:
		return
	await SaveManager.new_game()
	await TransitionManager.play_transition("fade_out")
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://UI/Intro_Scenes/God_Intro.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Settings_Menu/Settings_Menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
