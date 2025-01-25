extends AudioStreamPlayer3D
#
func _ready() -> void:
	var sound = GameSettingsManager.load_audio_setting()
	self.volume_db = linear_to_db(sound["Music volume"])
