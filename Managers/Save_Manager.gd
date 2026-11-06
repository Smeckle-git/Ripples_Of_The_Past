extends Node

"""
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SaveManager singleton will make us be able to actually save our game progress.

Honestly this doesn't do much yet, I'll be working on this a lot once we actually start to think of content for our levels.
not looking forward to this on.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

func has_save() -> bool:
	return FileAccess.file_exists(Dialogic.Save.get_slot_path("SavedGame").path_join("game.dat"))

func new_game() -> Error:
	await Dialogic.clear()
	var data: Dictionary = {
		"scene": "res://UI/Intro_Scenes/God_Intro.tscn",
		"world": "",
		"player_position": Vector3.ZERO,
		"GodRoom": {},
		"Level1": {},
		"dialogic": Dialogic.get_full_state()
	}
	return Dialogic.Save.save_file("SavedGame", "game.dat", data)

func save_game(world: Node, player: CharacterBody3D) -> Error:
	var data: Dictionary = {
		"scene": "res://Game.tscn",
		"world": world.scene_file_path,
		"player_position": player.global_position,
		
		"GodRoom": {},
		
		"Level1": {},
		
		"dialogic": Dialogic.get_full_state()
		
	}
	return Dialogic.Save.save_file("SavedGame", "game.dat", data)

func load_game():
	pass
