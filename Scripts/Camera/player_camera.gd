extends Camera3D
class_name Player_camera

@export var return_to_player: bool = false
@export var free_roam : bool = false
@export var move_to_global_position : Vector3

var player_camera_position

func _process(delta: float) -> void:
	if return_to_player:
		free_roam = false
		return_to_player = false
		self.global_position = player_camera_position
		player_camera_position = null
	
	if free_roam:
		if player_camera_position == null:
			player_camera_position = self.global_position
		self.global_position = move_to_global_position
