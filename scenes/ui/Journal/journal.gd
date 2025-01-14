extends Control

@onready var _continue: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/Continue
@onready var exit: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/Exit
@onready var back_to_main: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/BackToMain

@onready var game = $'../'
@onready var root = get_tree().current_scene

@onready var quest_text: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_text
@onready var quest_title: RichTextLabel = $MarginContainer2/VBoxContainer/TabContainer/Quests/Control/quest_title
@onready var map_forest: Sprite2D = $MarginContainer2/VBoxContainer/TabContainer/map/map_Forest
@onready var map_village: Sprite2D = $MarginContainer2/VBoxContainer/TabContainer/map/map_village



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/Continue.grab_focus()
	print_debug("loaded in just now")
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
	elif Input.is_action_just_pressed("Journal") and get_tree().paused:
		_on_continue_pressed()
		
func _process(delta: float) -> void:
	testFunc()
	Quest()
	
	#check_game_structure()

func check_game_structure() -> void:
	  # Gets the root of the current scene

	# Check if the root has a "Game" node
	if root.has_child("Game"):
		var game_node = root.get_node("Game")
		# Check if "Game" has either a "Level" or "Village" node
		if game_node.has_node("Level"):
			print("Game node contains a Level node.")
		elif game_node.has_node("Village"):
			print("Game node contains a Village node.")
		else:
			print("Game node exists but has neither Level nor Village nodes.")
	else:
		print("No Game node found in the root.")

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
		#cycle_all_nodes(child)
