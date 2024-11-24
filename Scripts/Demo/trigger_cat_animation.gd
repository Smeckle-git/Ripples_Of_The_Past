extends Area3D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_body_entered(body: Node3D) -> void:
	if body is Thorinn:
		var animation := animation_player.get_animation("Cat_intro")
		var track_index := animation.find_track("move_to_global_position", Animation.TYPE_POSITION_3D)
		animation.track_set_key_value(track_index, 0, body.camera.global_position)
		animation_player.play("Cat_intro")
		self.queue_free()
