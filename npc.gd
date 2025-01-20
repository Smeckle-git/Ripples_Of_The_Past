extends CharacterBody3D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var npc: CharacterBody3D = $"."
@onready var animation_player: AnimationPlayer = $Mage/AnimationPlayer



func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	Dialogic.start("DEMO_interaction")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	print("yes")
	

func _on_dialogic_signal(argument:String):
	if argument == "denied":
		animation_player.play("Lie_Down")
