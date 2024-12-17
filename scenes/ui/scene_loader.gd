extends Node

signal loaded()

@export var emit_loading_signal: bool = true
@export_file("*.tscn") var next_scene: String

var is_starting_scene : bool = true

@onready var pause_menu : MarginContainer = $PauseMenu

#func _ready() -> void:
	#SceneManager.transition_to(first_scene)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print_debug("test")
		SceneManager.transition_to(next_scene, self)	

func activate() -> void:
	pass
func load_scene() ->void: 
	await  get_tree().create_timer(3.0).timeout
	loaded.emit()
