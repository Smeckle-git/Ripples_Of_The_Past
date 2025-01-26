extends MarginContainer

@onready var game = $'../'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_divide_Slice/MainContainer/VBoxContainer2/VBoxContainer/Continue.grab_focus()


func _on_continue_pressed() -> void:
	game.pauseMenu()


func _on_load_pressed() -> void:
	print("Open savefile list")


func _on_settings_pressed() -> void:
	print("open settings scene")


func _on_back_to_main_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
