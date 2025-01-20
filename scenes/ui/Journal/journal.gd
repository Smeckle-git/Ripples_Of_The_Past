extends Control

@onready var _continue: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/Continue
@onready var root = get_tree().current_scene

@onready var quest_text: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_text
@onready var quest_title: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_title
@onready var map_forest: Sprite2D = $MarginContainer2/VBoxContainer/TabContainer/map/map_Forest
@onready var map_village: Sprite2D = $MarginContainer2/VBoxContainer/TabContainer/map/map_village

@onready var quests: TabBar = $MarginContainer2/VBoxContainer/TabContainer/Quests
@onready var settings: Control = $MarginContainer2/VBoxContainer/TabContainer/Settings


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer2/VBoxContainer/TabContainer/Settings/Continue.grab_focus()
	cycle_all_nodes(root)

func _on_back_to_main_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	

func testFunc():
	if Input.is_action_just_pressed("Journal") and !get_tree().paused:
		pause()
		quests.visible = true
	elif Input.is_action_just_pressed("Journal") and get_tree().paused:
		_on_continue_pressed()
		
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
		settings.visible = true
	elif Input.is_action_just_pressed("Pause") and get_tree().paused and settings.visible:
		_on_continue_pressed()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused and !settings.visible:
		settings.visible = true
	
func _process(delta: float) -> void:
	testFunc()
	Quest()

func Quest():
	var temp_title = GameHudManager.get_node("QuestLog/HUD/MarginContainer/HBoxContainer/Quest/MarginContainer/quest title")
	var temp_text = GameHudManager.get_node("QuestLog/HUD/MarginContainer/HBoxContainer/Quest/MarginContainer/quest text")
	
	quest_text.text = temp_text.text
	quest_title.text = temp_title.text

func cycle_all_nodes(node: Node):
	for child in node.get_children():
		print("Found node: ",child.name)
		if child.name =="Village":
			map_village.visible= true
			map_forest.visible = false
		else:
			map_village.visible= false
			map_forest.visible = true


func _on_settings_pressed() -> void:
	pass # Replace with function body.
