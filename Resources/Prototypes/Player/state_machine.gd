# statemachine.gd
extends Node
class_name StateMachine

@export var initial_state: State
@export var sprite : AnimatedSprite3D
@export var player : CharacterBody3D

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	
	print(states)
	
	if initial_state:
		current_state = initial_state
		current_state.Enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func change_state(old_state: State, new_state_name: String):
	if old_state != current_state:
		print("State error: current and old state don't match")
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state error: empty")
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
