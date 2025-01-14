extends Node
signal loaded()

@export var emit_loading_signal: bool = true
@export_file("*.tscn") var first_scene: String
@export_file("*.tscn") var next_scene: String

var is_starting_scene : bool = true

@onready var pause_menu : MarginContainer = $PauseMenu

func _ready() -> void:
	SceneManager.transition_to(first_scene)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_I):
		SceneManager.transition_to(next_scene)	

func activate() -> void:
	pass
func load_scene() ->void: 
	await  get_tree().create_timer(3.0).timeout
	loaded.emit()
