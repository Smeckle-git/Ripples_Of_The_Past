extends CanvasLayer

signal transitioned_in()
signal transitioned_out()
signal loaded()
@onready var LoadingScreens: CanvasLayer = $"."
@onready var animation_player: AnimationPlayer = $Loading_screen/AnimationPlayer
@onready var scene_loader: Node = $SceneLoader

func transition_to(scene: String, previous_scene: String)-> void:
	if previous_scene == null || scene == null:
		push_error("Scenes are not loaded in or something")
	
	var Game_root = get_node("/root/Game")
	
	transition_in()
	await transitioned_in
	print_debug(scene)
	var new_scene = load(scene).instantiate()
	new_scene.process_mode = PROCESS_MODE_PAUSABLE
	Game_root.add_child(new_scene)
	Game_root.get_node(previous_scene).queue_free()
	#
	#breakpoint
	#Game_root.find_child("Journal").queue_free()
	#await get_tree().process_frame
	#await get_tree().process_frame
	#
	if scene_loader.emit_loading_signal:
		load_scene()
		await loaded
	#
	#breakpoint
	#var journal_scene: PackedScene = load("res://scenes/ui/Journal/Journal.tscn")
	#var journal_node: Node = journal_scene.instantiate()
	#Game_root.add_child(journal_node)
	#Game_root.find_child("Journal").request_ready()
	#await get_tree().process_frame
	#await get_tree().process_frame
	#print_debug(Game_root.get_children() )
	#breakpoint
	#
	transition_out()
	await transitioned_out
	#scene_loader.ughhh = true

func transition_in() -> void:
	animation_player.play("Loading_in")
	LoadingScreens.visible = true
	
func transition_out():
	animation_player.play("Loading_out")
	LoadingScreens.visible = false
	
func load_scene() ->void: 
	print("test")
	await get_tree().create_timer(1.0).timeout
	loaded.emit()

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "Loading_in":
		animation_player.play("pulsing_text")
		transitioned_in.emit()
	if anim_name == "Loading_out":
		transitioned_out.emit()
