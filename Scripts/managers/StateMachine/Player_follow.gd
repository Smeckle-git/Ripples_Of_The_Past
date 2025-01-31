extends Player_State
class_name PlayerFollow

var disabled_inputs =["Interact"]
var stored_events = {}

func Enter():
	_disable_input()

func Physics_Update(_delta: float):
	if target:
		var direction = state_machine.follow_target.global_position - target.global_position
		if direction.length() > 1:
			target.velocity = Vector3(direction.x * 4, -4.5, direction.z * 4)
		else:
			target.velocity = Vector3(0,0,0)
		
func Exit():
	_enable_input()
	#re add the "interact" action from temp

func _disable_input():
	for action in disabled_inputs:
		if InputMap.has_action(action):
			stored_events[action] = InputMap.action_get_events(action)
			InputMap.action_erase_events(action)
		print_debug("input disabled") 

func _enable_input():
	for action in disabled_inputs:
		if action in stored_events:
			for event in stored_events[action]:
				InputMap.action_add_event(action, event)
			stored_events.erase(action)
		print("Input enabled")
