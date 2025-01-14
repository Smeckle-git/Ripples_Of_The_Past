extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

#create ini file with default settings if not exist, else load the saved settings
func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "Walk forward", "W")
		config.set_value("keybinding", "Walk forward2", "Up")
		config.set_value("keybinding", "Walk backwards", "S")
		config.set_value("keybinding", "Walk backwards2", "Down")
		config.set_value("keybinding", "Walk left", "A")
		config.set_value("keybinding", "Walk left2", "Left")
		config.set_value("keybinding", "Walk right", "Right")
		config.set_value("keybinding", "Walk right2", "D")
		config.set_value("keybinding", "Interact", "E")
		config.set_value("keybinding", "Interact2", "Space")
		config.set_value("keybinding", "Journal", "J")
		config.set_value("keybinding", "Journal2", "")
		config.set_value("keybinding", "Pause", "Escape")
		config.set_value("keybinding", "Pause2", "")
		
		config.set_value("audio", "Master voume", 1.0)
		config.set_value("audio", "Music volume", 1.0)
		config.set_value("audio", "Ambiant sound volume", 1.0)
		config.set_value("audio", "SFX vulue", 1.0)
		
		config.set_value("video", "Fullscreen", 0)
		config.set_value("video", "Resoltion", "1024x576")
		config.set_value("video", "Render distance", 1.0)
		
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
	
	remap_keys()

func remap_keys():
	var keys = config.get_section_keys("keybinding")
	for key in keys:
		if InputMap.has_action(key):
			InputMap.action_erase_events(key)
	
	print(InputMap.action_get_events("Walk forward"))
	
	for key in keys:
		var event_str = config.get_value("keybinding", key)
		key = key.trim_suffix("2")
		if event_str != "":
			var input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
			InputMap.action_add_event(key, input_event)
	
	print(InputMap.action_get_events("Walk forward"))


#functions to save to file
func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)

func save_keybinding(action: StringName, event: InputEvent):
	var event_str
	if event is InputEvent:
		event_str = OS.get_keycode_string(event.physical_keycode)
	config.set_value("keybinding", action, event_str)
	config.save(SETTINGS_FILE_PATH)


#functions to load from file
func load_audio_setting():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func load_video_setting():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings

func load_keybinding():
	var keybindings = {}
	var keys = config.get_section_keys("keybinding")
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinding", key)
		
		input_event = InputEventKey.new()
		input_event.keycode = OS.find_keycode_from_string(event_str)
		
		keybindings[key] = input_event
	return keybindings

func get_keybinding(binding : String) -> String:
	if config.get_value("keybinding", binding):
		return str(config.get_value("keybinding", binding))
	return "{Invalid Keybinding}"
