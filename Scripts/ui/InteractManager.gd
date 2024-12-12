extends Node3D
#Script from this tutorial video
#https://www.youtube.com/watch?v=ajCraxGAeYU&t=1s&ab_channel=DashNothing
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var label: Label3D = $Label


const base_text = "[E] to "

var active_areas = []
var can_interact = true
	
func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		#print(active_areas._sort_by_distance_to_player())
		active_areas.sort_custom(_sort_by_distance_to_player)
		print(active_areas)
		if active_areas[0].show_label:
			label.text = base_text + active_areas[0].action_name
			label.global_position = active_areas[0].global_position
			label.global_position.y = 3
			label.scale = Vector3(3,3,3) 
			label.show()
		else:
			label.hide()
	else:
		label.hide()

# checks distant of 2 given area's to thorfinn, The closes area can be interacted with. Except the companion, companion can only be interacted with when way from other area's
func _sort_by_distance_to_player(area1, area2):
	player = get_tree().get_first_node_in_group("Player")
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
#	Check if companion is 1 of 2 areas
	if area1.get_parent().get_name() == "Companion":
		return false
	elif area2.get_parent().get_name() == "Companion":
		return true
	else:
		return area1_to_player < area2_to_player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
