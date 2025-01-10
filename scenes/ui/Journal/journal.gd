extends Control

@onready var _continue: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/Continue
@onready var exit: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/Exit
@onready var back_to_main: Button = $MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/BackToMain

@onready var game = $'../'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer2/VBoxContainer/TabContainer/Settings/VBoxContainer/Continue.grab_focus()


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
