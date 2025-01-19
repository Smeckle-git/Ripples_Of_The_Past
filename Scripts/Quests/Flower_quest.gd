extends Node
class_name Flowers

@onready var find_flowers_quest: Quest = $Find_flowers_quest

var flowers = [load("res://scenes/environment/flowers/Purple_flower.tscn"), load("res://scenes/environment/flowers/Blue_flower.tscn"), load("res://scenes/environment/flowers/Orange_flower.tscn")]
var flower_nr = 0

func start():
	find_flowers_quest.start_quest()
	
	for child in get_children():
		if child is Marker3D:
			var flower_position = child.position
			spawn_flower(flower_position, find_flowers_quest)

func spawn_flower(position : Vector3, quest : Quest) -> void: 
	var flower = flowers[flower_nr].instantiate()
	add_child(flower)
	flower_nr += 1
	flower.position = position
	flower.quest = quest
