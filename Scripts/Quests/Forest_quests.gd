extends Node3D

@onready var companion: Companion = $Companion
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var thorinn: Thorinn = $Thorinn
@onready var campfire_merchant: Campfire_merchant = $Campfire_merchant
@onready var hugo: CharacterBody3D = $Hugo
@onready var player_camera: Player_camera = $Thorinn/PlayerCamera
@onready var village_door: village_door = $Village_door

@onready var root = get_node("/root/Game/Loading")

func _ready() -> void:
	
	companion.interaction_area.interact = Callable(self, "_on_companion_interact")
	campfire_merchant.interaction_area.interact = Callable(campfire_merchant, "_on_interact")
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_I):
		get_tree().change_scene_to_file("res://scenes/Levels/Game_2.tscn")

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
		thorinn.state_machine.follow_target = hugo
		thorinn.state_machine.change_state("follow")
		hugo.move_to_location = [Vector3(0,3,50),  Vector3(3,1.5,-50)]
		
		await  get_tree().create_timer(2.0).timeout
		root.scene_loader.change_scene("Village")
		
	elif argument == "leave_hugo":
		hugo.move_to_location = [Vector3(0,3,50),  Vector3(3,1.5,-50)]
		village_door.vfx_portal.visible = true
