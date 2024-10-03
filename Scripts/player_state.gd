extends state
class_name PlayerState

@onready var player: CharacterBody3D 
@onready var animation_player: AnimationPlayer

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
