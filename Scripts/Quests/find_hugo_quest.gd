extends Node3D
class_name find_ian

@onready var find_ian_quest: Quest = $Quest
@onready var ian_house: InteractionArea = $InteractionArea2
@onready var interaction_area_3: InteractionArea = $InteractionArea3
@onready var interaction_area_5: InteractionArea = $InteractionArea5
@onready var interaction_area_4: InteractionArea = $InteractionArea4

func _ready() -> void:
	interaction_area_3.interact = Callable(self, "start_find_ian_quest")
	interaction_area_5.interact = Callable(self, "start_find_ian_quest")
	interaction_area_4.interact = Callable(self, "start_find_ian_quest")
	ian_house.interact = Callable(self, "end_find_ian_quest")







func start_find_ian_quest():
	if find_ian_quest.quest_status == find_ian_quest.QuestStatus.available and Dialogic.VAR.Ian.find_ian_quest_avalible:
		find_ian_quest.start_quest()
		Dialogic.start("ask_for_ian_location")
		find_ian_quest.update_goal()
	elif Dialogic.VAR.Ian.find_ian_quest_avalible:
		find_ian_quest.update_goal()
		Dialogic.start("ask_for_ian_location")
	

func end_find_ian_quest():
	Dialogic.start("Iann_interaction")

func set_quest_to_end():
	find_ian_quest.start_quest()
	find_ian_quest.update_goal()
	find_ian_quest.update_goal()
	find_ian_quest.update_goal()
