extends Control

@onready var _continue: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/Continue
@onready var root = get_tree().current_scene

@onready var quest_text: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_text
@onready var quest_title: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_title

@onready var quests: TabBar = $MarginContainer2/VBoxContainer/TabContainer/Quests
@onready var settings: Control = $MarginContainer2/VBoxContainer/TabContainer/Settings

@onready var reset_keybinding: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/reset_keybinding
@onready var reset: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/Reset

signal reset_keybindings_signal
signal enable_settings_remap
signal disable_settings_remap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer2/VBoxContainer/TabContainer/Settings/Continue.grab_focus()
	#cycle_all_nodes(root)

func _on_back_to_main_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	disable_settings_remap.emit()
	_continue.disabled = true
	reset_keybinding.disabled = true
	reset.disabled = true
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	enable_settings_remap.emit()
	_continue.disabled = false
	reset_keybinding.disabled = false
	reset.disabled = false
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
	
func _process(_delta: float) -> void:
	testFunc()
	Quest()

func Quest():
	var temp_title = GameHudManager.get_node("QuestLog/HUD/MarginContainer/HBoxContainer/Quest/MarginContainer/quest title")
	var temp_text = GameHudManager.get_node("QuestLog/HUD/MarginContainer/HBoxContainer/Quest/MarginContainer/quest text")
	
	quest_text.text = temp_text.text
	quest_title.text = temp_title.text

#func cycle_all_nodes(node: Node):
	#for child in node.get_children():
		#print("Found node: ",child.name)
		#if child.name =="Village":
			#map_village.visible= true
			#map_forest.visible = false
		#else:
			#map_village.visible= false
			#map_forest.visible = true

func _on_reset_pressed() -> void:
	_on_continue_pressed()
	for child in root.get_children():
		print("Found node: ",child.name)
		for n in child.get_children():
			if n.name == "Thorinn":
				print_debug("manfound")
				n.global_transform.origin.z += 5

func _on_reset_keybinding_pressed() -> void:
	print_debug("reset keybindings")
	GameSettingsManager.reset_keybinding()
	reset_keybindings_signal.emit()
