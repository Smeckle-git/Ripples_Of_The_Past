extends CharacterBody3D
@onready var navigation_agent_3d: NavigationAgent3D = get_node("NavigationAgent3D")
@onready var companion: CharacterBody3D = $"."
@onready var erick: CharacterBody3D = $"../erick"




#https://www.youtube.com/watch?v=qg2kzZVe2RI&ab_channel=GamedevAki
#https://www.youtube.com/watch?v=iV710Vm5qm0&ab_channel=LegionGames
const SPEED = 10.0
#const JUMP_VELOCITY = 4.5


func _ready() -> void:
	print(' ok')
	pass
	#navigation_agent_3d.path_desired_distance = 200.0
	#navigation_agent_3d.target_desired_distance = 50.0
	#navigation_agent_3d.path_max_distance = 200.0
func _physics_process(delta: float) -> void:
	move_and_slide()
	var direction = erick.global_position - companion.global_position
	print(direction)
	print(direction.length())
	if direction.length() > 6:
		print('lol')
		companion.velocity = direction.normalized() * SPEED
	elif direction.length() > 2:
		companion.velocity = direction.normalized() * SPEED / 2
	else:
		companion.velocity = Vector3(0,0,0)
