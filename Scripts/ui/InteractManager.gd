extends Node3D
#Script from this tutorial video
#https://www.youtube.com/watch?v=ajCraxGAeYU&t=1s&ab_channel=DashNothing
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var label: Label3D = $Label

var interact_key
var base_text

var active_areas = []
var can_interact = true


func _ready() -> void:
	interact_key = GameSettingsManager.get_keybinding("Interact")
	base_text = "[" + interact_key + "]" + " to "
	var custom_font = load("res://scenes/ui/Font/Laura_font_file.tres")  
	label.set("theme_override_fonts/font", custom_font) 

	
func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(_delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		if active_areas[0].show_label:
			interact_key = GameSettingsManager.get_keybinding("Interact")
			base_text = "[" + interact_key + "]" + " to "
			label.text = base_text + active_areas[0].action_name
			label.global_position = active_areas[0].global_position
			label.global_position.y = label.global_position.y + 1
			label.scale = Vector3(3,3,3) 
			label.show()
		else:
			label.hide()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	player = get_tree().get_first_node_in_group("Player")
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	
	if area1.is_in_group("Companion"):
		return false
	elif area2.is_in_group("Companion"):
		return true
	else:
		return area1_to_player < area2_to_player

func _input(event: InputEvent) -> void:
	if active_areas.size() > 0:
		if event.is_action_pressed("Interact") && can_interact:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
