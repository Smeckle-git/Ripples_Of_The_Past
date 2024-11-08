extends Area3D
class_name InteractionArea

@export var action_name: String = "interact"
@export var show_label := true

var interact: Callable = func():
	pass


func _on_body_entered(body: Node3D) -> void:
	print(body)
	InteractManager.register_area(self)
	

func _on_body_exited(body: Node3D) -> void:
	InteractManager.unregister_area(self)
