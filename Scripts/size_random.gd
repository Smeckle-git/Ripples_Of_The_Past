extends Node3D

var min_size = 0.95
var max_size = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#set_scale(Vector3(randi_range(min_size,max_size),randi_range(min_size,max_size),randi_range(min_size,max_size)))
	$Sprite3D.transform.origin = Vector3(0, 0.5, 0)
