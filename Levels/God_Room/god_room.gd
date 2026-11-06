extends Node3D

#we only have this function so we don't need to restart the full game and can load the full scene including UI
#please remind me to do this for all the worlds we'll have :P
func _ready() -> void:
	if get_parent() == get_tree().root:
		add_child(preload("res://UI/Gameplay/Gameplay_UI.tscn").instantiate())
