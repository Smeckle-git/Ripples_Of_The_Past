extends Node3D

@onready var companion: Companion = $Companion
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var thorinn: Thorinn = $Thorinn
@onready var campfire_merchant: Campfire_merchant = $Campfire_merchant
@onready var hugo: CharacterBody3D = $Hugo

func _ready() -> void:
	companion.interaction_area.interact = Callable(self, "_on_companion_interact")
	campfire_merchant.interaction_area.interact = Callable(campfire_merchant, "_on_interact")
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _on_companion_interact():
	companion.interaction_area.show_label = false
	Dialogic.start("wiskers_start_campfire_quest")
	companion.following = true


func _on_dialogic_signal(argument:String):
	if argument == "cat_leaves":
		companion.following = false
		companion.move_to_location = Vector3(-20, 2.3, 65)
	elif argument == "start_fish_quest":
		campfire_merchant.start_fish_qest()
	elif argument == "hugo_encounter":
		Dialogic.VAR.Whiskers.Forest_Interaction_phase += 1
		Dialogic.start("wiskers_start_campfire_quest")
		hugo.global_position = Vector3(1,2.5,62)
		hugo.visible = true
		hugo.move_to_location = [thorinn.global_position + Vector3(1,0,0)]
		Dialogic.start("wiskers_start_campfire_quest")
	elif argument == "thorinn_looks_right":
		thorinn.state_machine.last_direction = Vector2(1,0)
	elif argument == "follow_hugo":
		pass
	elif argument == "leave_hugo":
		hugo.move_to_location = [Vector3(0,3,50),  Vector3(3,1.5,-50)]
