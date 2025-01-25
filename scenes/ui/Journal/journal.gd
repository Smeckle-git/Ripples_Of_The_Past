extends Control

@onready var self_layer = $".."
@onready var quest_manager = QuestManager

@onready var _continue: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/Continue
@onready var root = get_tree().current_scene

@onready var quest_text: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_text
@onready var quest_title: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_title
@onready var quest_details: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_description

@onready var quests: TabBar = $MarginContainer2/VBoxContainer/TabContainer/Quests
@onready var settings: Control = $MarginContainer2/VBoxContainer/TabContainer/Settings


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer2/VBoxContainer/TabContainer/Settings/Continue.grab_focus()

func _on_back_to_main_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")


func _on_exit_pressed() -> void:
	self_layer.visible = false
	get_tree().quit()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	self_layer.visible = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	

func testFunc():
	if Input.is_action_just_pressed("Journal") and !get_tree().paused:
		pause()
		self_layer.visible = true
		quests.visible = true
	elif Input.is_action_just_pressed("Journal") and get_tree().paused:
		_on_continue_pressed()
		
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
		self_layer.visible = true
		settings.visible = true
	elif Input.is_action_just_pressed("Pause") and get_tree().paused and settings.visible:
		_on_continue_pressed()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused and !settings.visible:
		self_layer.visible = true
		settings.visible = true
	
func _process(_delta: float) -> void:
	testFunc()
	Quest()

func Quest():
	var temp_title = GameHudManager.get_node("QuestLog/HUD/MarginContainer/Quest/MarginContainer/quest title")
	var temp_text = GameHudManager.get_node("QuestLog/HUD/MarginContainer/Quest/MarginContainer/quest text")
	var temp_details = GameHudManager.get_node("QuestLog/HUD/MarginContainer/Quest/MarginContainer/quest details")
	
	quest_title.text = temp_title.text
	quest_text.text = temp_text.text
	quest_details.text = temp_details.text


func _on_reset_pressed() -> void:
	_on_continue_pressed()
	for child in root.get_children():
		if child.name == "Level":
			for n in child.get_children():
				if n.name == "Thorinn":
					print_debug("manfound")
					n.global_transform.origin.z += 0.5
		elif child.name == "Village":
			for char in child.get_children():
				if char.name == "Character":
					for n in char.get_children():
						if n.name == "Thorinn":
							print_debug("manfound")
							n.global_transform.origin.x += 0.5


func _on_button_pressed() -> void:
	pause()
	self_layer.visible = true
	quests.visible = true
