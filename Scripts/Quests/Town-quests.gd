extends Node
@onready var flower_girl: Vivian = $Character/FlowerGirl
@onready var thorinn: Thorinn = $Character/Thorinn
@onready var find_ian_quest: find_ian = $find_Ian_quest
@onready var hugo: Hugo = $Character/Hugo
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
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


func _on_hugo_destination_reached() -> void:
	pass
	#dialg for entering the inn
	#dailog for start new find ian quest
