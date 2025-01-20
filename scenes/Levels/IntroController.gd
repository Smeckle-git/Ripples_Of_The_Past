extends Control

@export var IntroBackground1 : TextureRect
@export var IntroBackground2 : TextureRect
@export var IntroBackground3 : TextureRect
@export var IntroBackground4 : TextureRect
@export var IntroBackground5 : TextureRect

var IntroBackgrounds: Array = []
var current_background_index: int = 0

# disables the devkeys
# TODO: as a late fix, make a global variable for devmode to enable / disable all the debug keys!!!
var devMode : bool = 0

func _ready():
	IntroBackgrounds = [
		IntroBackground1, 
		IntroBackground2, 
		IntroBackground3, 
		IntroBackground4, 
		IntroBackground5
	]
	
	_update_visibility()
	Dialogic.start("IntroTimeline")
	Dialogic.signal_event.connect(_on_dialogic_event)

func _process(delta: float):
	# for Debug functionality only
	if Input.is_action_just_pressed("ui_right"):
		if devMode:
			_next_background()
	elif Input.is_action_just_pressed("ui_left"):
		if devMode:
			_previous_background()

func _next_background():
	# Move to the next background in the list
	current_background_index += 1
	if current_background_index >= IntroBackgrounds.size():
		current_background_index = 0
	_update_visibility()

func _previous_background():
	# Move to the previous background in the list
	current_background_index -= 1
	if current_background_index < 0:
		current_background_index = IntroBackgrounds.size() - 1
	_update_visibility()

func _update_visibility():
	# Set visibility of backgrounds based on the current index
	for i in range(IntroBackgrounds.size()):
		IntroBackgrounds[i].visible = (i == current_background_index)

func _on_dialogic_event(argument : String):
	if argument == "proceed_intro_background":
		_next_background()
	if argument == "proceed_into_demo":
		get_tree().change_scene_to_file("res://scenes/Levels/Game.tscn")
