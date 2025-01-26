extends CharacterBody3D
class_name Vivian

@onready var interaction_area_2: InteractionArea = $InteractionArea2
@onready var collect_flowers_quest: Quest = $Collect_flowersQuest
@onready var sparkles: Node3D = $Sparkles

var flowers = [load("res://scenes/environment/flowers/Purple_flower.tscn"), load("res://scenes/environment/flowers/Blue_flower.tscn"), load("res://scenes/environment/flowers/Red_flower.tscn"), load("res://scenes/environment/flowers/Pink_flower.tscn")]
var flower_nr = 0

func Flower_quest():
	if collect_flowers_quest.quest_status == collect_flowers_quest.QuestStatus.available:
		collect_flowers_quest.start_quest()
		
		for child in get_children():
			if child is Marker3D:
				var flower_position = child.position
				spawn_flower(flower_position, collect_flowers_quest)
		
	elif collect_flowers_quest.quest_status == collect_flowers_quest.QuestStatus.reached_goal:
		collect_flowers_quest.finish_quest()
		
		Dialogic.VAR.Vivian.Interaction_phase += 1
		Dialogic.VAR.Vivian.New_Dialog = true
		Dialogic.start("flower_girl_quest")
		
		sparkles.get_child(0).emitting = true
	else:
		Dialogic.start("flower_girl_quest")
	


func spawn_flower(position : Vector3, quest : Quest) -> void: 
	var flower = flowers[flower_nr].instantiate()
	add_child(flower)
	flower_nr += 1
	flower.position = position
	flower.quest = quest

func collected() ->void:
	collect_flowers_quest.update_goal()
	queue_free()
