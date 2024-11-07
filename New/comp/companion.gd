extends CharacterBody3D
@onready var companion: CharacterBody3D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@export var quest : Quest
const SPEED = 10.0

var wood_1:=load("res://Resources/Images/sprites/Campfire/Wood_1.png")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.

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


func _physics_process(delta: float) -> void:
	move_and_slide()
	#var direction = erick.global_position - companion.global_position
	#print(direction)
	#print(direction.length())
	#if direction.length() > 6:
		#print('lol')
		#companion.velocity = direction.normalized() * SPEED
	#elif direction.length() > 2:
		#companion.velocity = direction.normalized() * SPEED / 2
	#else:
		#companion.velocity = Vector3(0,0,0)
