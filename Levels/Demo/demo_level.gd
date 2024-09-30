extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug(get_tree().current_scene.name)
