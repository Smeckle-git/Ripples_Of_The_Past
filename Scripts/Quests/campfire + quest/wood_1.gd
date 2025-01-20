extends Area3D

var quest : Quest
var picked_up = false
#@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node3D) -> void:
	print(self)
	if body.is_in_group("Player") and !picked_up:
		picked_up = true
		quest.update_goal()
		#get_tree().get_root().get_child(2).play("anim/Disolve")
		get_child(2).play("anim/Disolve")
		#print(get_child(2))
		await get_tree().create_timer(1).timeout
		queue_free()
