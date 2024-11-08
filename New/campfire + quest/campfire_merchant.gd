extends Area3D
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var interaction_area: InteractionArea = $InteractionArea
@export var quest : Quest

var wood_1:=load("res://New/campfire + quest/Wood_1.tscn")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

# gebruik om de quest te starten
func _on_interact():
	if quest.quest_status == quest.QuestStatus.available:
		quest.start_quest()
		var new_wood_1 = wood_1.instantiate()
		add_child(new_wood_1)
		new_wood_1.position = $Wood_1_marker.position
		new_wood_1.quest = quest
#	dit is voor het op pakken van een element van de quest 
	if quest.quest_status == quest.QuestStatus.reached_goal:
		quest.finish_quest()

func collected() ->void:
	quest.update_goal()
	queue_free()
