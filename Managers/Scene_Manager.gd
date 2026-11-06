extends Node

"""
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The SceneManager singleton is responsible for loading and switching between scenes.

Use `change_scene()` to replace the whole scene, such as entering Game after the intro.
Use `change_world()` to replace only the level inside Game's World node, keeping Game and its UI.
Scenes load in the background while gameplay is paused and TransitionManager displays the loading screen.
The `is_loading` variable prevents another scene switch from starting before the current one finishes.
Once the new scene is ready, the transition reveals it and gameplay resumes.

we're actualy loading the scene now instead of faking a loading screen and hoping the new scene got switched in time.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

var is_loading: bool = false

#replace the whole scene
func change_scene(path: String) -> void:
	if is_loading:
		return
	var scene: PackedScene = await _load_scene(path)
	get_tree().change_scene_to_packed(scene)
	await get_tree().scene_changed
	await _finish_loading()

# Replace only the level, keeping Game and its UI.
func change_world(path: String) -> void:
	if is_loading:
		return
	var scene: PackedScene = await _load_scene(path)
	var world: Node = get_tree().current_scene.get_node("World")
	for previous_world in world.get_children():
		world.remove_child(previous_world)
		previous_world.queue_free()
	world.add_child(scene.instantiate())
	await _finish_loading()

func _load_scene(path: String) -> PackedScene:
	is_loading = true
	get_tree().paused = true

	# Cover the screen while the new scene loads in the background.
	ResourceLoader.load_threaded_request(path, "PackedScene")
	await TransitionManager.cover_for_loading()
	while ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame
	var scene: PackedScene = ResourceLoader.load_threaded_get(path)
	return scene

func _finish_loading() -> void:
	await get_tree().process_frame
	await TransitionManager.reveal_after_loading()
	get_tree().paused = false
	is_loading = false
