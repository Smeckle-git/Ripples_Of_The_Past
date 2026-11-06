extends Node
class_name PlayerStateMachine

@export var target : CharacterBody3D
@export var animation_tree : AnimationTree

@export var follow_target : CharacterBody3D

# Dict of possible states that are assigned to this state machine
var states : Dictionary = {} 
@export var current_state : PlayerState

# Fills the states Dict with all the child states of the state machine
# On entering sets the player physics and process to the assigned starting state
func _ready() -> void:
	for child in get_children():
		if child is PlayerState:
			states[child.name] = child
			# Connects all the transition signals from the states to the change state function in this machine
			child.state_transition.connect(change_state)
	
	if current_state:
		current_state.Enter()

# Uses the Update and Physics_Update function from the current active state
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
	manage_animations()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)
		target.move_and_slide()

# Changes state whenever a state has send a state_transition signal
func change_state(new_state_name : String):
	var new_state = states.get(new_state_name)
	if !new_state:
		print("new state error empty" + new_state_name)
		return
	
	# Activates old states exit code
	if current_state:
		current_state.Exit()
	
	# Enters new state
	new_state.Enter()
	current_state = new_state


var last_direction := Vector2(0, 1)
func manage_animations():
	if target.velocity != Vector3.ZERO and current_state.name != "PlayerDialogue":
		last_direction = Vector2(target.velocity.x, target.velocity.z) 
	
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walking/blend_position", last_direction)
