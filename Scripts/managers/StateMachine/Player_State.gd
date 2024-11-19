extends Node
class_name Player_State

signal state_transition

@onready var state_machine : PlayerStateMachine = get_parent()
@onready var target : CharacterBody3D = state_machine.target

@export var speed = 7

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	pass
	
func Physics_Update(_delta:float):
	pass
