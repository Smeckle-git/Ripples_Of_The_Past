extends Node3D
class_name NPC

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var Dead_body: Sprite3D = $Sprite3D2

func turn_dead():
	sprite_3d.visible = false
	Dead_body.visible = true
