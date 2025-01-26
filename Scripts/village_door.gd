extends Node3D
class_name village_door

@onready var interaction_area: InteractionArea = $Portal_spawn/InteractionArea
@onready var vfx_portal: Node3D = $Portal_spawn/VFX_Portal
@onready var root = get_node("/root/Game/Loading")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vfx_portal.visible = false
	pass # Replace with function body.

func _on_object_int():
	root.scene_loader.change_scene("Village")
# Called every frame. 'delta' is the elapsed time since the previous frame.
