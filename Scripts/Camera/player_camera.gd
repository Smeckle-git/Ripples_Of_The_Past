extends Camera3D
class_name Player_camera

@export var return_to_player: bool = false
@export var free_roam : bool = false
@export var move_to_global_position : Vector3

var player_camera_position

@export var default_position : Vector3 = Vector3(-0.75, 20, 17)
@export var default_rotation_degrees : Vector3 = Vector3(-30, 0, 0)

@export var camera_movement_time : float = 0.40

@export var backwards_walking_zoom_out: float = 1

@warning_ignore("narrowing_conversion")
var time_step_max : int = camera_movement_time * Engine.physics_ticks_per_second
var time_step_x : float = 0
var time_step_y : float = 0

var rotation_step_max: float = 15#degrees
var rotation_step: float = 0

func _ready() -> void:
	position = default_position
	#print_debug(position)

func _process(_delta: float) -> void:
	if return_to_player:
		free_roam = false
		return_to_player = false
		self.global_position = player_camera_position
		player_camera_position = null
	
	if free_roam:
		if player_camera_position == null:
			player_camera_position = self.global_position
		self.global_position = move_to_global_position

func _physics_process(_delta: float) -> void:
	var direction_x = Input.get_axis("Walk left", "Walk right")
	if direction_x == 1:
		if time_step_x < time_step_max:
			time_step_x += 1
	elif direction_x == -1:
		if time_step_x > -time_step_max:
			time_step_x -= 1
	else:
		if time_step_x > 0:
			time_step_x -= 1
		elif time_step_x < 0:
			time_step_x += 1
	position.x = default_position.x + (3 * time_step_x)/time_step_max

	var direction_y = Input.get_axis("Walk forward", "Walk backwards")
	if direction_y == 1:
		if time_step_y < time_step_max and time_step_y > -time_step_max:
			@warning_ignore("narrowing_conversion")
			time_step_y += direction_y
		#
		if rotation_step < rotation_step_max:
			rotation_step += 0.25
	else:
		if time_step_y > 0:
			time_step_y -= 1
		elif time_step_y < 0:
			time_step_y += 1
		#
		if rotation_step > 0:
			rotation_step -= 0.5
	#position.y = default_position.y# + (default_position.y * time_step_y) / time_step_max
	position.z = default_position.z + (backwards_walking_zoom_out \
	* default_position.z * time_step_y) / time_step_max
	#
	rotation_degrees.x = default_rotation_degrees.x - rotation_step
	#print_debug(time_step_y, " ", position.y, " ", position.z)
	#print_debug("position.z: ", position.z, ", rotation_degrees.x: ", rotation_degrees.x)
