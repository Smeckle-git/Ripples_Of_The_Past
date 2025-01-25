extends VBoxContainer

# visual format
var visual_format = " %s"

# Music Volume Slider
@onready var ms_slider: HSlider = $"SoundOptions/Music/MS-Slider"
@onready var ms_visual: Label = $"SoundOptions/Music/MS-visual"
var music_volume_value : int

# Ambient Sound Volume Slider
@onready var am_slider: HSlider = $"SoundOptions/Ambience/AM-Slider"
@onready var am_visual: Label = $"SoundOptions/Ambience/AM-visual"
var ambient_volume_value : int

# SFX Sound Volume Slider
@onready var sfx_slider: HSlider = $"SoundOptions/SoundEffects/SFX-Slider"
@onready var sfx_visual: Label = $"SoundOptions/SoundEffects/SFX-Visual"
var sfx_volume_value : int

func _ready() -> void:
	
	music_volume_value = ms_slider.value
	ms_visual.text  = visual_format % music_volume_value
	
	ambient_volume_value = am_slider.value
	am_visual.text  = visual_format % ambient_volume_value
	
	sfx_volume_value = sfx_slider.value
	sfx_visual.text = visual_format % sfx_volume_value

func _on_ms_slider_value_changed(value: float) -> void:
	music_volume_value = value
	ms_visual.text  = visual_format % music_volume_value

func _on_am_slider_value_changed(value: float) -> void:
	ambient_volume_value = value
	am_visual.text  = visual_format % ambient_volume_value

func _on_sfx_slider_value_changed(value: float) -> void:
	sfx_volume_value = value
	sfx_visual.text = visual_format % sfx_volume_value
