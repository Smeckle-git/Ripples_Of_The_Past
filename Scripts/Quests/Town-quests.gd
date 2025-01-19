extends Node
@onready var thorinn: Thorinn = $Character/Thorinn
@onready var find_ian_quest: Quest = $Quests/Find_ian_quest
@onready var hugo: Hugo = $Character/Hugo
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var directional_light_3d: DirectionalLight3D = $Environment/WorldEnvironment/DirectionalLight3D
@onready var Hospital: InteractionArea = $Buildings/BuildingHospital/InteractionArea
@onready var return_to_inn: Quest = $Quests/Return_to_inn
@onready var alinora: CharacterBody3D = $Character/Alinora
@onready var marlic: NPC = $Character/Marlic
@onready var tree: Magic_tree = $Buildings/Tree
@onready var find_book_quest: Quest = $Quests/Find_book_quest
@onready var collectflowers: Flowers = $Quests/Collectflowers
@onready var astrid: NPC = $Character/Astrid
@onready var vivian: NPC = $Character/Vivian
@onready var marcellus: NPC = $Character/marcellus




func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	Hospital.interact = Callable(self, "_on_hospital_interaction")
	hugo.interaction_area.interact = Callable(self, "_on_inn_interaction")
	marlic.interaction_area.interact = Callable(self, "_on_marlic_interaction")
	tree.interaction_area.interact = Callable(self, "_on_tree_interact")
	astrid.interaction_area.interact = Callable(self, "_on_astrid_interact")
	vivian.interaction_area.interact = Callable(self, "_on_vivian_interact")
	marcellus.interaction_area.interact = Callable(self, "_on_marcellus_interact")
	
	#thorinn.state_machine.follow_target = hugo
	#thorinn.state_machine.change_state("follow")
	#hugo.move_to_location = [Vector3(78.838, 2.57, 67.381), Vector3(74.978, 2.57, 70.043), Vector3(71.93, 3.52, 71.431), Vector3(64.001, 3.52, 77.358), Vector3(57.87, 3.52, 77.358), Vector3(54.056, 1.957, 75.402), Vector3(46.614, 1.557, 67.844), Vector3(39.94, 1.557, 64.231)]
	
	collectflowers.start()
	
	if !Dialogic.VAR.Hugo.Followed_to_rockfall:
		hugo.visible = false

func _on_dialogic_signal(argument:String):
	if argument == "start_night":
		animation_player.play("Time warp in")
	elif argument == "end-night":
		animation_player.play("Time warp out")
	elif argument == "change_to_day_light":
		directional_light_3d.light_color = Color("#8b8042")
	elif argument == "Start_Find_Ian":
		hugo.interaction_area.show_label = true
		thorinn.state_machine.change_state("Idle")
		find_ian_quest.start_quest()
	elif argument == "End_Find_Ian":
		directional_light_3d.light_color = Color("#02758f")
		return_to_inn.start_quest()
		hugo.visible = false
	elif argument == "Scene_5_switch":
		return_to_inn.finish_quest()
		thorinn.global_position = Vector3(42,1.6,-4)
		alinora.visible = true
		marlic.visible = true
		hugo.interaction_area.show_label = false
		Hospital.show_label = false
		tree.switch_sprite()
	elif argument == "start_alinora_interaction":
		Dialogic.start("Astrid_request")
	elif argument == "Start_find_another_way_quest":
		find_book_quest.start_quest()
	elif argument == "Start_flower_quest":
		find_book_quest.finish_quest()
		collectflowers.start()

func _on_vivian_interact():
	Dialogic.VAR.selected_character = 1
	Dialogic.start("Choose_which_villager_to_kill")

func _on_astrid_interact():
	Dialogic.VAR.selected_character = 2
	Dialogic.start("Choose_which_villager_to_kill")

func _on_marcellus_interact():
	Dialogic.VAR.selected_character = 3
	Dialogic.start("Choose_which_villager_to_kill")

func _on_tree_interact():
	Dialogic.start("Tree_interaction")

func _on_marlic_interaction():
	Dialogic.start("Malrik_Cure")

func _on_inn_interaction():
	Dialogic.start("Return_to_inn")

func _on_hospital_interaction():
	find_ian_quest.finish_quest()
	Dialogic.start("pharmacy_location")

func _on_hugo_destination_reached() -> void:
	Dialogic.start("first_morning")
	hugo.visible = true
	pass
