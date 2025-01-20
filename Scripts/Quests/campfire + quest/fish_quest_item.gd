extends Node3D
@onready var interaction_area: InteractionArea = $InteractionArea

var quest : Quest

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_fish_interact")

func _on_fish_interact():
	quest.update_goal()
	self.queue_free()
