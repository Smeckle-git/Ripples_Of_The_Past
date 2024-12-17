extends CanvasLayer

signal transitioned_in()
signal transitioned_out()

var current_scene: Node: set= set_current_scene
@onready var scene_loader: Node = $"."
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $Loading_screen/AnimationPlayer
@onready var label: Label = $Loading_screen/VBoxContainer/HBoxContainer/VBoxContainer_sprite/Label

func _ready() -> void:
	current_scene = get_tree().current_scene

func set_current_scene(value:Node) -> void:
	if current_scene == null:
		current_scene = value
		return
	current_scene = value
	var root: Window = get_tree().get_root()
	
	root.get_child(root.get_child_count() - 1 ).free()
	root.add_child(value)

func transition_in() -> void:
	animation_player.play("Loading_in")

func transition_out():
	animation_player.play("Loading_out")

func transition_to(scene: String)-> void:
	transition_in()
	await transitioned_in
	var new_scene = load(scene).instantiate()
	current_scene = new_scene

	scene_loader.load_scene()
	
	if scene_loader.emit_loading_signal:
		await scene_loader.loaded
		
	transition_out()
	await transitioned_out
	new_scene.activate()

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "Loading_in":
		animation_player.play("pulsing_text")
		transitioned_in.emit()
	if anim_name == "Loading_out":
		transitioned_out.emit()
