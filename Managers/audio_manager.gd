extends Node

"""
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The AudioManager singleton autoload is responsible for managing all audio buses in the project.

There are four audio buses:
- Master: Controls the overall game volume.
- Music: Background music.
- Ambient: Environmental sounds.
- SFX: Sound effects.

Use the corresponding play function for each type of audio so it is routed through the correct bus and affected by the appropriate volume setting.

In our old version we only used one audio stream to play everything, how we ended up removing all the audio settings we had.
Now we can actually do stuff with audio. so if you want to do more emersive background noise we now have a stream for that.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

const MAIN_THEME = preload("res://Resources/Music/main_theme.mp3")

@onready var music_player = $Music_Player
@onready var ambiant_player = $Ambiant_Player
@onready var sfx_player = $SFX_Player

func _ready() -> void:
	play_music(MAIN_THEME)

func apply_audio_settings():
	set_audio_volume("Master", SettingsManager.get_setting("audio", "master_volume"))
	set_audio_volume("Music", SettingsManager.get_setting("audio", "music_volume"))
	set_audio_volume("Ambiant", SettingsManager.get_setting("audio", "ambiant_sound_volume"))
	set_audio_volume("SFX", SettingsManager.get_setting("audio", "sfx_volume"))

func set_audio_volume(bus_name: String, volume: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	
	if bus_index == -1:
		push_error("Audio bus not found: ", bus_name)
		pass

	if volume <= 0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume))

func play_music(stream: AudioStream):
	music_player.stream = stream
	music_player.play()

func stop_music():
	music_player.stop()

func play_ambiant(stream: AudioStream):
	ambiant_player.stream = stream
	ambiant_player.play()

func stop_ambiant():
	ambiant_player.stop()

func play_sfx(stream: AudioStream):
	sfx_player.stream = stream
	sfx_player.play()

func stop_sfx():
	sfx_player.stop()

func stop_all_audio():
	stop_music()
	stop_ambiant()
	stop_sfx()
