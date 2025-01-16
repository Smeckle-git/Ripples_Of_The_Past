extends Node
@onready var thorinn: Thorinn = $Character/Thorinn
@onready var find_ian_quest = $Quests/Find_ian_quest
@onready var hugo: Hugo = $Character/Hugo
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var Hospital: InteractionArea = $Buildings/BuildingHospital/InteractionArea
@onready var directional_light_3d: DirectionalLight3D = $Environment/WorldEnvironment/DirectionalLight3D

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	Hospital.interact = Callable(self, "_on_hospital_interaction")
	
	thorinn.state_machine.follow_target = hugo
	thorinn.state_machine.change_state("follow")
	hugo.move_to_location = [Vector3(78.838, 2.57, 67.381), Vector3(74.978, 2.57, 70.043), Vector3(71.93, 3.52, 71.431), Vector3(64.001, 3.52, 77.358), Vector3(57.87, 3.52, 77.358), Vector3(54.056, 1.957, 75.402), Vector3(46.614, 1.557, 67.844), Vector3(39.94, 1.557, 64.231)]
	
	if !Dialogic.VAR.Hugo.Followed_to_rockfall:
		hugo.visible = false

func _on_dialogic_signal(argument:String):
	if argument == "start_night":
		animation_player.play("Time warp in")
	elif argument == "end-night":
		animation_player.play("Time warp out")
	elif argument == "change_to_day_light":
		directional_light_3d.light_color = Color("#8b8042")
	elif argument == "": #dialogic signal from end of morning <-------------------
		find_ian_quest.start_find_ian_quest()

func _on_hospital_interaction():
	find_ian_quest.end_find_ian_quest()
	Dialogic.start("") #interaction with Ian <-------------------

func _on_hugo_destination_reached() -> void:
	Dialogic.start("first_morning")
