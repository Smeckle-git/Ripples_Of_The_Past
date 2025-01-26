extends Control
##
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
	##random sprite
	##var count = sprite_group.get_child_count()
	##var i = randi_range(0, count - 1)
	##print_debug("sprite number ", i)
	##sprite_group.get_child(i).visible = true
	##
	##random background
	##count = background_group.get_child_count()
	##i = randi_range(0, count - 1)
	##print_debug("background number ", i)
	##background_group.get_child(i).visible = true
	##
	#destination = preload("res://scenes/Levels/world.tscn")
	##destination = ResourceLoader.load(destination_scene.resource_path)
	#destination.instantiate()
	##automatic switching
	#if automatic_scene_change == true:
		#continue_lable.text = "Loading, please wait"
		#await get_tree().create_timer(minimum_wait_time).timeout
		##get_tree().call_deferred("change_scene_to_packed", destination_scene)
		#get_tree().call_deferred("change_scene_to_packed", destination)
		##randomness test
		##get_tree().call_deferred("change_scene_to_file", "res://scenes/ui/loading_screens.tscn")
##
#func _process(_delta: float) -> void:
	#if automatic_scene_change == false and Input.is_anything_pressed():
		##get_tree().call_deferred("change_scene_to_packed", destination_scene)
		#get_tree().call_deferred("change_scene_to_packed", destination)
		##randomness test
		##get_tree().call_deferred("change_scene_to_file", "res://scenes/ui/loading_screens.tscn")
