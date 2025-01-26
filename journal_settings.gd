extends Control
@onready var forward1: Button = $Controls/MarginContainer/VBoxContainer/Movement/Forward/Button
@onready var forward2: Button = $Controls/MarginContainer/VBoxContainer/Movement/Forward/Button2
@onready var backwards1: Button = $Controls/MarginContainer/VBoxContainer/Movement/Back/Button
@onready var backwards2: Button = $Controls/MarginContainer/VBoxContainer/Movement/Back/Button2
@onready var right2: Button = $Controls/MarginContainer/VBoxContainer/Movement/Right/Button
@onready var right1: Button = $Controls/MarginContainer/VBoxContainer/Movement/Right/Button2
@onready var left1: Button = $Controls/MarginContainer/VBoxContainer/Movement/Left/Button
@onready var left2: Button = $Controls/MarginContainer/VBoxContainer/Movement/Left/Button2
@onready var interact1: Button = $Controls/MarginContainer/VBoxContainer/Interactions/HBoxContainer2/Button
@onready var interact2: Button = $Controls/MarginContainer/VBoxContainer/Interactions/HBoxContainer2/Button2
@onready var journal1: Button = $Controls/MarginContainer/VBoxContainer/System/HBoxContainer2/Button
@onready var journal2: Button = $Controls/MarginContainer/VBoxContainer/System/HBoxContainer2/Button2
@onready var pause1: Button = $Controls/MarginContainer/VBoxContainer/System/HBoxContainer3/Button
@onready var pause2: Button = $Controls/MarginContainer/VBoxContainer/System/HBoxContainer3/Button2

@onready var ms_slider: HSlider = $"Sound/MarginContainer/SoundControlContainer/SoundOptions/Music/MS-Slider"
@onready var am_slider: HSlider = $"Sound/MarginContainer/SoundControlContainer/SoundOptions/Ambience/AM-Slider"
@onready var sfx_slider: HSlider = $"Sound/MarginContainer/SoundControlContainer/SoundOptions/SoundEffects/SFX-Slider"


func set_value():
	var keybinds = GameSettingsManager.load_keybinding()
	forward1.text = keybinds["Walk forward"].as_text()
	forward1.pressed.connect(on_input_button_pressed.bind(forward1, "Walk forward"))
	forward2.text = keybinds["Walk forward2"].as_text()
	forward2.pressed.connect(on_input_button_pressed.bind(forward2, "Walk forward2"))
	backwards1.text = keybinds["Walk backwards"].as_text()
	backwards1.pressed.connect(on_input_button_pressed.bind(backwards1, "Walk backwards"))
	backwards2.text = keybinds["Walk backwards2"].as_text()
	backwards2.pressed.connect(on_input_button_pressed.bind(backwards2, "Walk backwards2"))
	left1.text = keybinds["Walk left"].as_text()
	left1.pressed.connect(on_input_button_pressed.bind(left1, "Walk left"))
	left2.text = keybinds["Walk left2"].as_text()
	left2.pressed.connect(on_input_button_pressed.bind(left2, "Walk left2"))
	right1.text = keybinds["Walk right"].as_text()
	right1.pressed.connect(on_input_button_pressed.bind(right1, "Walk right"))
	right2.text = keybinds["Walk right2"].as_text()
	right2.pressed.connect(on_input_button_pressed.bind(right2, "Walk right2"))
	interact1.text = keybinds["Interact"].as_text()
	interact1.pressed.connect(on_input_button_pressed.bind(interact1, "Interact"))
	interact2.text = keybinds["Interact2"].as_text()
	interact2.pressed.connect(on_input_button_pressed.bind(interact2, "Interact2"))
	journal1.text = keybinds["Journal"].as_text()
	journal1.pressed.connect(on_input_button_pressed.bind(journal1, "Journal"))
	journal2.text = keybinds["Journal2"].as_text()
	journal2.pressed.connect(on_input_button_pressed.bind(journal2, "Journal2"))
	pause1.text = keybinds["Pause"].as_text()
	pause1.pressed.connect(on_input_button_pressed.bind(pause1, "Pause"))
	pause2.text = keybinds["Pause2"].as_text()
	pause2.pressed.connect(on_input_button_pressed.bind(pause2, "Pause2"))
	
	var audio = GameSettingsManager.load_audio_setting()
	ms_slider.value = min(audio["Music volume"], 1.0) * 100
	am_slider.value = min(audio["Ambiant sound volume"], 1.0) * 100
	sfx_slider.value = min(audio["SFX vulue"], 1.0) * 100
	
func _ready() -> void:
	set_value()

func _on_ms_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		GameSettingsManager.save_audio_setting("Music volume", ms_slider.value / 100)


func _on_am_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		GameSettingsManager.save_audio_setting("Ambiant sound volume", am_slider.value / 100)


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		GameSettingsManager.save_audio_setting("SFX vulue", sfx_slider.value / 100)




var is_remapping = false
var action_to_remap = null
var original_action = null
var remapping_button = null

func on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		original_action = button.text
		button.text = "Press key..."

func _input(event: InputEvent) -> void:
	if is_remapping:
		if event is InputEventKey:
			for events in InputMap.action_get_events(action_to_remap.trim_suffix("2")):
				if events.as_text().trim_suffix(" (Physical)") == original_action:
					InputMap.action_erase_event(action_to_remap.trim_suffix("2"), events)
			
			InputMap.action_add_event(action_to_remap.trim_suffix("2"), event)
			GameSettingsManager.save_keybinding(action_to_remap, event)
			
			remapping_button.text = event.as_text().trim_suffix(" (Physical)")
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			original_action = null
			
			accept_event()
