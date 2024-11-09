extends Node3D

@onready var directional_light_3d: DirectionalLight3D = $DirectionalLight3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P): # DEBUG VARIANT
		trigger_nightfall()

func trigger_nightfall():
	# make "inbetween" for the transition between dusk -> night
	var tween = get_tree().create_tween()
	
	var duraction : float = 2.0 # speed of the color transition
	var night_color : Color = Color("#02758F") # color in hex
	
	# Use the tween to animate the color change
	tween.tween_property(directional_light_3d, "light_color", night_color, duraction).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
