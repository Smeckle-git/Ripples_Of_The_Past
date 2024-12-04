extends Control
#
@export var minimum_wait_time: float = 4.0
@export var game_scene: PackedScene
@export var sprite_group: Control
@export var background_group: Control
#
func _ready() -> void:
	#print_debug("loading screen start")
	#random sprite
	var count = sprite_group.get_child_count()
	var i = randi_range(0, count - 1)
	print_debug("sprite number ", i)
	sprite_group.get_child(i).visible = true
	#
	#random background
	count = background_group.get_child_count()
	i = randi_range(0, count - 1)
	print_debug("background number ", i)
	background_group.get_child(i).visible = true
	#
	#load game scene and wait
	var world = load("res://scenes/Levels/world.tscn")
	await get_tree().create_timer(minimum_wait_time).timeout
	#print_debug("loading screen finished, moving to scene")
	get_tree().call_deferred("change_scene_to_packed", world)
	#randomness test
	#get_tree().call_deferred("change_scene_to_file", "res://scenes/ui/loading_screens.tscn")
#
#func _process(_delta: float) -> void:
	#pass
