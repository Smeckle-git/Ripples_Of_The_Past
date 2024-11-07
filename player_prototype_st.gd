## player.gd
#extends CharacterBody3D
#
#@onready var state_machine: StateMachine = $StateMachine
#
#func _ready() -> void:
	## Initialize the state machine and enter the initial state
	#if state_machine.initial_state:
		#state_machine.current_state = state_machine.initial_state
		#state_machine.current_state.Enter()
#
#func _process(delta: float) -> void:
	## Update the current state
	#if state_machine.current_state:
		#state_machine.current_state.Update(delta)
#
#func _physics_process(delta: float) -> void:
	## Call physics update on the state machine
	#state_machine._physics_process(delta)
