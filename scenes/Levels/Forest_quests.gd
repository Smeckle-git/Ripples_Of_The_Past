extends Node3D

@onready var companion: Companion = $Companion
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var thorinn: Thorinn = $Thorinn
@onready var campfire_merchant: Campfire_merchant = $Campfire_merchant


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
	elif argument == "hugo_encounter":
		pass
