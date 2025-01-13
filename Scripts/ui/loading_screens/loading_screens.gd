extends Control
## NOT BEING USED////////////////////////////////////////////////////////////////////////
#@export var automatic_scene_change: bool
#@export var minimum_wait_time: float = 4.0
#@export var continue_lable: Label
#@export var destination_scene: PackedScene
##@export var destination_scene_string: String
#@export var sprite_group: Control
#@export var background_group: Control
##
#var destination
##
#func _ready() -> void:
#
	#destination = preload("res://scenes/Levels/world.tscn")
	##destination = ResourceLoader.load(destination_scene.resource_path)
	#destination.instantiate()
	##automatic switching
	#if automatic_scene_change == true:
		#continue_lable.text = "Loading, please wait"
		#await get_tree().create_timer(minimum_wait_time).timeout
		##get_tree().call_deferred("change_scene_to_packed", destination_scene)
		#print_debug()
		#get_tree().call_deferred("change_scene_to_packed", destination)
		##randomness test
		##get_tree().call_deferred("change_scene_to_file", "res://scenes/ui/loading_screens.tscn")
##
##func _process(_delta: float) -> void:
	##if automatic_scene_change == false and Input.is_anything_pressed():
		###get_tree().call_deferred("change_scene_to_packed", destination_scene)
		##get_tree().call_deferred("change_scene_to_packed", destination)
		##randomness test
		##get_tree().call_deferred("change_scene_to_file", "res://scenes/ui/loading_screens.tscn")
