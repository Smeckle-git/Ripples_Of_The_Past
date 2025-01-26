extends Node

signal loaded()
#///////////////////////////// DONT USE NEXT_SCENE AS VARIABLE ITS CORRUPT./////////////////////////////////////////////////////////

@onready var LoadingScreens = get_parent()
@export var emit_loading_signal: bool = true
var target_folder = "res://scenes/Levels/Destinations/"
var target_scene: String = "Level" #CHANGEEEEEEEEEEEE
var current_scene: String


	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("go_to_village") :
		#print_debug(target_scene)
		change_scene(target_scene)

func change_scene(new_scene:String):

	if current_scene == "":
		current_scene = "Intro"  #CHANGEEEEEEEEEEEE
	if current_scene == new_scene:
		print("Is the same scene")
		
	else:	
		LoadingScreens.transition_to(target_folder + new_scene + ".tscn", current_scene)
		current_scene = new_scene
		
func activate() -> void:
	pass
