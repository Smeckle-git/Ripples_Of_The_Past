extends Control
#
@export var game_scene: PackedScene
@export var sprite_group: Control
#
#@onready var sprite

#



#
func _ready() -> void:
	var count = sprite_group.get_child_count()
	var i = randi_range(0, count - 1)
	sprite_group.get_child(i).visible = true
	#
	
	#
	var world = load("res://scenes/Levels/world.tscn")
	#call_deferred("get_tree")
	#get_tree().change_scene_to_packed(world)
	get_tree().call_deferred("change_scene_to_packed", world)
	#call_deffered("get_tree().change_scene_to_packed(world)")
	#get_tree().change_scene_to_file("res://scenes/Levels/world.tscn")
	pass # Replace with function body.
#
func _process(_delta: float) -> void:
	
	
	
	pass
