extends Area3D

# variables for campfire animation
@onready var animated_sprite_3d_2: AnimatedSprite3D = $AnimatedSprite3D2
@onready var omni_light_3d: OmniLight3D = $AnimatedSprite3D2/AnimatedSprite3D/OmniLight3D
@onready var sprite_3d: Sprite3D = $Sprite3D
@export var noise: NoiseTexture3D
var time_passed := 0.0


# variables for campfire quest
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var interaction_area: InteractionArea = $InteractionArea
@export var quest : Quest


#load items to collect
var wood_1:=load("res://New/campfire + quest/Wood_1.tscn")

#link interact signal to function
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

# starts the quest whenever the player interacts with the campfire
func _on_interact():
	if quest.quest_status == quest.QuestStatus.available:
		quest.start_quest()
		var new_wood_1 = wood_1.instantiate()
		add_child(new_wood_1)
		new_wood_1.position = $Wood_1_marker.position
		new_wood_1.quest = quest
#	dit is voor het op pakken van een element van de quest 
	if quest.quest_status == quest.QuestStatus.reached_goal:
		quest.finish_quest()
		campfire_on == true


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
	else :
		animated_sprite_3d_2.visible = false
		omni_light_3d.light_energy = 0
	
	if campfire_extinguished:
		sprite_3d.frame = 1
	else :
		sprite_3d.frame = 0
