extends Node3D

@onready var directional_light_3d: DirectionalLight3D = $DirectionalLight3D


var daylight_color : Color
var night_color : Color = Color("#02758F") # color in hex
var is_night : bool = false

func _ready() -> void:
	daylight_color = directional_light_3d.light_color
	
	print_debug(daylight_color)

func trigger_nightfall(new_color : Color):
	# make "inbetween" for the transition between dusk -> night
	var tween = get_tree().create_tween()
	
	var duraction : float = 2.0 # speed of the color transition

	# Use the tween to animate the color change
	tween.tween_property(directional_light_3d, "light_color", new_color, duraction).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
