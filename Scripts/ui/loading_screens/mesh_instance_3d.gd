extends MeshInstance3D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var root = get_parent().get_node("../Loading")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_object_int")
	pass # Replace with function body.

func _on_object_int():
	root.scene_loader.change_scene("Level")
# Called every frame. 'delta' is the elapsed time since the previous frame.
