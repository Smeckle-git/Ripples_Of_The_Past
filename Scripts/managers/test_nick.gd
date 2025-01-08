extends Node3D
#@onready var scene_manager: CanvasLayer = $Camera3D/SceneManager
@onready var path_follow_3d: PathFollow3D = $Path3D/PathFollow3D

signal loaded()

@export var emit_loading_signal: bool = true
@export_file("*.tscn") var next_scene: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Journal"):
		SceneManager.transition_to(next_scene)
	
	

	
func activate() -> void:
	pass
	
func load_scene() ->void: 
	await  get_tree().create_timer(3.0).timeout
	loaded.emit()
