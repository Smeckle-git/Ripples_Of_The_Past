extends Node

"""
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The SettingsManager singleton is responsible for creating, loading and saving all user settings.

Settings are stored in a `user://settings.ini` file and are automatically loaded when the game starts.
This manager applies keybindings to the InputMap and provides functions to get and modify settings.
Any changes made through this manager are automatically saved for future game sessions.

this pretty much is the same as the one I made in our earlier version. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		set_default_settings()
	load_settings()
	AudioManager.apply_audio_settings()

#if there was no settings file yet, a new one gets created with these as default values
func set_default_settings():
	config.set_value("keybinding", "move_forward", [_make_key_event(KEY_W), _make_key_event(KEY_UP)])
	config.set_value("keybinding", "move_left", [_make_key_event(KEY_A), _make_key_event(KEY_LEFT)])
	config.set_value("keybinding", "move_backward", [_make_key_event(KEY_S), _make_key_event(KEY_DOWN)])
	config.set_value("keybinding", "move_right", [_make_key_event(KEY_D), _make_key_event(KEY_RIGHT)])
	config.set_value("keybinding", "interact", [_make_key_event(KEY_E), null])
	config.set_value("keybinding", "journal", [_make_key_event(KEY_J), null])
	config.set_value("keybinding", "pause", [_make_key_event(KEY_ESCAPE), null])

	config.set_value("audio", "master_volume", 1.0)
	config.set_value("audio", "music_volume", 1.0)
	config.set_value("audio", "ambiant_sound_volume", 1.0)
	config.set_value("audio", "sfx_volume", 1.0)
	
	config.set_value("video", "fullscreen", false)
	config.set_value("video", "resoltion", "1920x1080")

	config.save(SETTINGS_FILE_PATH)

func load_settings():
	config.load(SETTINGS_FILE_PATH)
	apply_keybindings()

#keybines get applied into the input map from the saved file
func apply_keybindings():
	for action in config.get_section_keys("keybinding"):
		if !InputMap.has_action(action):
			continue
		InputMap.action_erase_events(action)
		var events: Array = config.get_value("keybinding", action, [])
		for event in events:
			if event is InputEvent:
				InputMap.action_add_event(action, event)

#if the user changes a keybind it gets saved in the config file and the inputmap gets reloaded
func change_keybind(action: String, slot: int, event: InputEvent):
	var bindings: Array = config.get_value("keybinding", action)
	bindings[slot] = event
	config.set_value("keybinding", action, bindings)
	config.save(SETTINGS_FILE_PATH)
	apply_keybindings()

func get_setting(section: String, action: String):
	return config.get_value(section, action)

func set_setting(section: String, action: String, value):
	config.set_value(section, action, value)
	config.save(SETTINGS_FILE_PATH)
	if section == "audio":
		AudioManager.apply_audio_settings()

func _make_key_event(keycode: Key) -> InputEventKey:
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	return event
