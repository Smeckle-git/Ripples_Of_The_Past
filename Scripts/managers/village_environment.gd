extends Node3D

@onready var directional_light_3d: DirectionalLight3D = $WorldEnvironment/DirectionalLight3D


var daylight_color : Color = Color("#a09d71") # color in hex
var night_color :  Color

var is_night : bool = true

func _ready() -> void:
	night_color = directional_light_3d.light_color
	print_debug(night_color)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P): # DEBUG VARIANT
		if is_night:
			trigger_night_or_day(daylight_color)
			is_night = !is_night
			
		else:
			trigger_night_or_day(night_color)
			is_night = !is_night


func trigger_night_or_day(new_color : Color):
	# make "inbetween" for the transition between dusk -> night
	var tween = get_tree().create_tween()
	
	var duraction : float = 2.0 # speed of the color transition

	# Use the tween to animate the color change
	tween.tween_property(directional_light_3d, "light_color", new_color, duraction).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
