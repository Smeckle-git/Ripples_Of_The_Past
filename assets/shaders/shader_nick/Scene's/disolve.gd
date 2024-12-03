extends Node3D

@onready var animatie: AnimationPlayer = $Animatie
const DISOLVE = preload("res://assets/shaders/shader_nick/Scene's/Disolve.res")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(animatie)
	animatie.play("Disolve")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:

	
