extends Control

@onready var Texture_Rect = $TextureRect

var slides = [
	preload("res://Resources/Images/Scenes/Into_Scene_1.jpg"),
	preload("res://Resources/Images/Scenes/Into_Scene_2.jpg"),
	preload("res://Resources/Images/Scenes/Into_Scene_3.jpg"),
	preload("res://Resources/Images/Scenes/Into_Scene_4.jpg")
]

var slide_order = [0,1,2,3,1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Texture_Rect.texture = slides[slide_order.pop_front()]
	await TransitionManager.play_transition("fade_in")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_intro_finished, CONNECT_ONE_SHOT)
	Dialogic.start("test_timeline")

func _on_dialogic_signal(argument:String):
	if argument == "proceed_intro_background" and not slide_order.is_empty():
		Texture_Rect.texture=slides[slide_order.pop_front()]

func _on_intro_finished() -> void:
	# Let Dialogic finish its own cleanup before removing the intro scene.
	_open_god_room.call_deferred()

func _open_god_room() -> void:
	SceneManager.change_scene("res://Game.tscn")
