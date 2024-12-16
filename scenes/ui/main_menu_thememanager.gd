extends AudioStreamPlayer2D

func _ready() -> void:
	var soundOptions = GameSettingsManager.load_audio_setting()
	self.volume_db = linear_to_db(soundOptions["Music volume"])
