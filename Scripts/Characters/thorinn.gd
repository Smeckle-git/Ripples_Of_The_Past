extends CharacterBody3D
class_name Thorinn
@onready var state_machine: PlayerStateMachine = $StateMachine

func _process(_delta: float) -> void:
	print_debug(global_position)
