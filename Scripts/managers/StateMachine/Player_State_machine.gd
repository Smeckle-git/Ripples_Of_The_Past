extends Node
class_name PlayerStateMachine

@export var target : CharacterBody3D
@export var animation_tree : AnimationTree


# Dict of possible states that are assigned to this state machine
var states : Dictionary = {} 
@export var current_state : Player_State

# Fills the states Dict with all the child states of the state machine
# On entering sets the player physics and process to the assigned starting state
func _ready() -> void:
	for child in get_children():
		if child is Player_State:
			states[child.name.to_lower()] = child
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
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("new state error empty")
		return
	
	# Activates old states exit code
	if current_state:
		current_state.Exit()
	
	# Enters new state
	new_state.Enter()
	current_state = new_state


var last_direction := Vector2(0, 1)
func manage_animations():
	var input_direction := Vector2(
		Input.get_axis("Walk left", "Walk right"),
		Input.get_axis("Walk forward", "Walk backwards")
	)
	
	if input_direction != Vector2.ZERO and current_state.name != "Dialogue":
		last_direction = input_direction
	
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walking/blend_position", last_direction)
