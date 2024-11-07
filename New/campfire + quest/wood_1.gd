extends Area3D

var quest : Quest

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		quest.update_goal()
		queue_free()
