extends HBoxContainer

@onready var name_label = $HBoxContainer/Name
@onready var slider = $HBoxContainer2/HSlider
@onready var percentage_label = $HBoxContainer2/Percentage

var audio_setting_key: String

func setup(name: String, value: float):
	
	audio_setting_key = name
	
	name_label.text = name.replace("_", " ").capitalize()
	slider.value = SettingsManager.get_setting("audio", name)
	percentage_label.text = str(int(value * 100)) + "%"

func _on_h_slider_value_changed(value: float) -> void:
	percentage_label.text = str(int(value * 100)) + "%"
	SettingsManager.set_setting("audio", audio_setting_key, value)
