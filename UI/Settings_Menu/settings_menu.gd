extends Control

const KEYBIND_ROW = preload("res://UI/Settings_Menu/Input_Key_Row.tscn")
const VOLUME_SLIDER = preload("res://UI/Settings_Menu/Volume_Slider.tscn")

@onready var galery_container = $MarginContainer/Galery
@onready var credits_container = $MarginContainer/Credits
@onready var settings_container = $MarginContainer/Settings
@onready var settings_rows = $MarginContainer/Settings/Settings
@onready var back_button = $BackButton
@onready var title = $Title

var is_remapping := false
var remapping_action := ""
var remapping_slot = -1
var remapping_row: InputKeyRow

func _ready() -> void:
	create_keybind_rows()
	create_volume_sliders()

func _on_rebind_request(action, slot, row):
	if !is_remapping:
		is_remapping = true
		remapping_action = action
		remapping_slot = slot
		remapping_row = row
		
		if remapping_slot == 0:
			remapping_row.button_1.text = "remapping..."
		elif remapping_slot == 1:
			remapping_row.button_2.text = "remapping..."

func create_keybind_rows():
	for action in SettingsManager.config.get_section_keys("keybinding"):
		var row = KEYBIND_ROW.instantiate()
		settings_rows.add_child(row)
		row.setup(action, SettingsManager.get_setting("keybinding", action))
		row.rebind_request.connect(_on_rebind_request)

func create_volume_sliders():
	for action in SettingsManager.config.get_section_keys("audio"):
		var slider = VOLUME_SLIDER.instantiate()
		settings_rows.add_child(slider)
		slider.setup(action, SettingsManager.get_setting("audio", action))

func _input(event: InputEvent) -> void:
	if is_remapping:
		if event is InputEventKey:
			SettingsManager.change_keybind(remapping_action, remapping_slot, event)
			remapping_row.setup(remapping_action, SettingsManager.get_setting("keybinding", remapping_action))
			is_remapping = false

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu/Main_Menu.tscn")

func _on_settings_button_pressed() -> void:
	title.text = "Settings"
	settings_container.visible = true
	galery_container.visible = false
	credits_container.visible = false

func _on_galery_button_pressed() -> void:
	title.text = "Galery"
	settings_container.visible = false
	galery_container.visible = true
	credits_container.visible = false

func _on_credits_button_pressed() -> void:
	title.text = "Credits"
	settings_container.visible = false
	galery_container.visible = false
	credits_container.visible = true
