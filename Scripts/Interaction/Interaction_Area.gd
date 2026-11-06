extends Area3D
class_name InteractionArea

signal interacted

@export var action_name: String = "interact"
@export var enabled: bool = true
@export var show_label: bool = true
@export var interaction_priority: int = 0
@export var prompt_offset: Vector3 = Vector3(0, 2, 0)
@export_file("*.dtl") var dialogue_timeline: String = ""

var interact: Callable
var _player: Node3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _exit_tree() -> void:
	InteractionManager.unregister_area(self)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		_player = body
		InteractionManager.register_area(self)

func _on_body_exited(body: Node3D) -> void:
	if body == _player:
		InteractionManager.unregister_area(self)
		_player = null

func get_player() -> Node3D:
	return _player if is_instance_valid(_player) else null

func is_available() -> bool:
	return enabled and (interact.is_valid() or not dialogue_timeline.is_empty())

func activate() -> void:
	if not is_available():
		return
	if interact.is_valid():
		await interact.call()
	elif not dialogue_timeline.is_empty():
		Dialogic.start(dialogue_timeline)
		await Dialogic.timeline_ended
	else:
		interacted.emit()
