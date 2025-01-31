extends Player_State
class_name player_Dialogue

var disabled_inputs =["Interact"]
var stored_events = {}

func Enter():
	if target:
		target.velocity = Vector3(0, 0, 0)
		_disable_input()
		#create a temp var that saves the "interact" action the inputmap
		#remove "interact" from inputmap

func Update(_delta:float):
	if Dialogic.current_timeline == null:
		state_transition.emit("idle")

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
