extends Button

# Pressed Event back to Main Menu
func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")
