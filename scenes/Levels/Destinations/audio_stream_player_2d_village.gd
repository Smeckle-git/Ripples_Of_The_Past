extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()  # Start playing when the scene starts

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var soundOptions = GameSettingsManager.load_audio_setting()
	self.volume_db = linear_to_db(soundOptions["Music volume"])
	if not playing:  # Check if audio has stopped
		play()  # Restart the audi
