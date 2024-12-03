extends Area3D

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
@export var quest : Quest


#load items to collect
var wood_1 := load("res://scenes/environment/Wood_1.tscn")

#link interact signal to function
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

# starts the quest whenever the player interacts with the campfire
func _on_interact():
	if quest.quest_status == quest.QuestStatus.available:
		Dialogic.start("quest1_start")
		quest.start_quest()
		
		var wood1_position = $Wood_1_marker.position
		spawn_wood(wood1_position, quest)
		
		var wood2_position = $Wood_2_marker.position
		spawn_wood(wood2_position, quest)
		
#	dit is voor het op pakken van een element van de quest 
	if quest.quest_status == quest.QuestStatus.reached_goal:
		quest.finish_quest()
		sparkles.get_child(0).emitting = true
		Dialogic.start("quest1_end")
		campfire_on = true
		progression_block.queue_free()

func spawn_wood(position : Vector3, quest : Quest) -> void: 
	var wood = wood_1.instantiate()
	add_child(wood)
	
	wood.position = position
	wood.quest = quest

# quest progression
func collected() ->void:
	quest.update_goal()
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
