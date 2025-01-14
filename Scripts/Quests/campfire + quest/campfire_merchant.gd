extends Area3D
class_name Campfire_merchant

# variables for campfire animation
@onready var animated_sprite_3d_2: AnimatedSprite3D = $AnimatedSprite3D2
@onready var omni_light_3d: OmniLight3D = $AnimatedSprite3D2/AnimatedSprite3D/OmniLight3D
@onready var sprite_3d: Sprite3D = $Sprite3D
@export var noise: NoiseTexture3D
var time_passed := 0.0

var night_triggered = false
@onready var directional_light_3d: DirectionalLight3D = $"../Environment/DirectionalLight3D"
@onready var progression_block: StaticBody3D = $"../Environment/Progression_block"
@onready var fire_flies: Node3D = $"../FireFlies"
@onready var sparkles: Node3D = $Sparkles

# variables for campfire quest
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var interaction_area: InteractionArea = $InteractionArea
@export var find_materials_quest : Quest
@export var find_fish_quest: Quest


#load items to collect
var wood_1 := load("res://scenes/environment/Wood_1.tscn")
var stone_1 := load("res://scenes/environment/Stone_1.tscn")
var fish_1 := load("res://scenes/environment/Fish_quest_item.tscn")

# starts the quest whenever the player interacts with the campfire
func _on_interact():
	print_debug("campfire interacted")
	if find_fish_quest.quest_status == find_fish_quest.QuestStatus.reached_goal:
		find_fish_quest.finish_quest()
		sparkles.get_child(0).emitting = true
		Dialogic.start("Fish_quest_completion")
	
	elif find_materials_quest.quest_status == find_materials_quest.QuestStatus.available and Dialogic.VAR.Whiskers.New_Dialog == false:
		find_materials_quest.start_quest()
		
		var wood1_position = $Wood_1_marker.position
		spawn_wood(wood1_position, find_materials_quest)
		
		var wood2_position = $Wood_2_marker.position
		spawn_wood(wood2_position, find_materials_quest)
		
		var wood3_position = $Wood_3_marker.position
		spawn_wood(wood3_position, find_materials_quest)
		
		var stone1_position = $Stone_1_marker.position
		spawn_Stone(stone1_position, find_materials_quest)
		
		var stone2_position = $Stone_2_marker.position
		spawn_Stone(stone2_position, find_materials_quest)
		
		var stone3_position = $Stone_3_marker.position
		spawn_Stone(stone3_position, find_materials_quest)
		
		var stone4_position = $Stone_4_marker.position
		spawn_Stone(stone4_position, find_materials_quest)
		
		var stone5_position = $Stone_5_marker.position
		spawn_Stone(stone5_position, find_materials_quest)
		
		
#	dit is voor het op pakken van een element van de quest 
	elif find_materials_quest.quest_status == find_materials_quest.QuestStatus.reached_goal:
		find_materials_quest.finish_quest()
		sparkles.get_child(0).emitting = true
		
		Dialogic.VAR.Whiskers.Forest_Interaction_phase += 1
		Dialogic.VAR.Whiskers.New_Dialog = true
		Dialogic.start("wiskers_start_campfire_quest")
		
		campfire_on = true
		progression_block.queue_free()

func start_fish_qest():
	if find_fish_quest.quest_status == find_fish_quest.QuestStatus.available:
		find_fish_quest.start_quest()
		
		var fish1_position = $Fish_1_marker.position
		spawn_Fish(fish1_position, find_fish_quest)
		
		var fish2_position = $Fish_2_marker.position
		spawn_Fish(fish2_position, find_fish_quest)


func spawn_wood(position : Vector3, quest : Quest) -> void: 
	var wood = wood_1.instantiate()
	add_child(wood)
	
	wood.position = position
	wood.scale *= 0.5
	wood.quest = quest

func spawn_Stone(position : Vector3, quest : Quest) -> void: 
	var stone = stone_1.instantiate()
	add_child(stone)
	
	stone.position = position
	stone.scale *= 0.5
	stone.quest = quest

func spawn_Fish(position : Vector3, quest : Quest) -> void: 
	var fish = fish_1.instantiate()
	add_child(fish)
	
	fish.position = position
	fish.quest = quest


# quest progression
func collected() ->void:
	find_materials_quest.update_goal()
	
	queue_free()
	


#bool to keep track of campfire state (I don't want to make a state machine for this :,)
@export var campfire_on := false
@export var campfire_extinguished := false


# campfire animation and states
func _process(delta: float) -> void:
	if campfire_on:
		animated_sprite_3d_2.visible = true
		time_passed += delta
		var noise_sample = noise.noise.get_noise_1d(time_passed)
		omni_light_3d.light_energy = 1 + abs(noise_sample) * 4
		
		if !night_triggered:
			trigger_nightfall()
			night_triggered = true
			fire_flies.visible = true
	else :
		animated_sprite_3d_2.visible = false
		omni_light_3d.light_energy = 0
	
	if campfire_extinguished:
		sprite_3d.frame = 1
	else :
		sprite_3d.frame = 0

func trigger_nightfall():
	# make "inbetween" for the transition between dusk -> night
	var tween = get_tree().create_tween()
	var duraction : float = 5.0 # speed of the color transition
	var night_color : Color = Color("#02758F") # color in hex
	
	interaction_area.show_label = false
	
	# Use the tween to animate the color change
	tween.tween_property(directional_light_3d, "light_color", night_color, duraction).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
