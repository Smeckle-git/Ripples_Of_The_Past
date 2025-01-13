extends Node

signal loaded()
#///////////////////////////// DONT USE NEXT_SCENE AS VARIABLE ITS CORRUPT./////////////////////////////////////////////////////////

@onready var LoadingScreens = get_parent()
@export var emit_loading_signal: bool = true
var target_folder = "res://scenes/Levels/nodes/"
var target_scene: String = "Village"
var current_scene: String = "Level"


	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") :
		#print_debug(target_scene)
		change_scene(current_scene,target_scene)

func change_scene(old_scene:String, new_scene:String):
	if old_scene == new_scene:
		print("Is the same scene")
	else:	
		LoadingScreens.transition_to(target_folder + new_scene + ".tscn",old_scene)
		current_scene = target_scene
		
func activate() -> void:
	pass
