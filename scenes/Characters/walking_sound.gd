extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
	var soundOptions = GameSettingsManager.load_audio_setting()
	self.volume_db = linear_to_db(soundOptions["SFX vulue"])
