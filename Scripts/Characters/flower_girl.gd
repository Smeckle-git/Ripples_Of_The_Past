extends CharacterBody3D
@onready var interaction_area_2: InteractionArea = $InteractionArea2
@onready var collect_flowers_quest: Quest = $Collect_flowersQuest
@onready var sparkles: Node3D = $Sparkles

var flowers = [load("res://scenes/environment/flowers/Purple_flower.tscn"), load("res://scenes/environment/flowers/Blue_flower.tscn"), load("res://scenes/environment/flowers/Red_flower.tscn"), load("res://scenes/environment/flowers/Pink_flower.tscn")]

func _onInteract():
	if collect_flowers_quest.QuestStatus.available:
		collect_flowers_quest.start_quest()
		
		for Marker3D in get_children():
			var flower_position = Marker3D.position
			spawn_flower(flower_position, collect_flowers_quest)
		
	elif collect_flowers_quest.quest_status == collect_flowers_quest.QuestStatus.reached_goal:
		collect_flowers_quest.finish_quest()
		
		Dialogic.VAR.Vivian.Interaction_phase += 1
		Dialogic.VAR.Vivian.New_Dialog = true
		Dialogic.start("flower_girl_quest")
		
		sparkles.get_child(0).emitting = true

func spawn_flower(position : Vector3, quest : Quest) -> void: 
	var wood = wood_1.instantiate()
	add_child(wood)
	
	wood.position = position
	wood.quest = quest
