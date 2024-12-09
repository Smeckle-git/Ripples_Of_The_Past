extends Node
@onready var flower_girl: Vivian = $Character/FlowerGirl
@onready var thorinn: Thorinn = $Character/Thorinn
@onready var find_ian_quest: find_ian = $find_Ian_quest


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flower_girl.interaction_area_2.interact = Callable(self, "_on_Vivian_interact")
	Dialogic.signal_event.connect(_on_dialogic_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Vivian_interact():
	if Dialogic.VAR.Vivian.flower_quest_accepted:
		flower_girl.Flower_quest()
	else:
		Dialogic.start("flower_girl_quest")

func _on_dialogic_signal(argument:String):
	if argument == "Accept_flower_quest":
		flower_girl.Flower_quest()
	if argument == "start_find_ian_quest":
		find_ian_quest.set_quest_to_end()
