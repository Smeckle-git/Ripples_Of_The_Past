extends Node

"""
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
InteractionManager singleton manages the interaction areas in the playable world.

this still pretty much wroks the same way as we had before. Laura please don't ask me too much about this,
Nick made it and I tried my best to simplify for you to understand but it's a headache part of our project. XD

All you rly need to know is add a InteractionArea to a object, set the variables and give it a CollisionShape3D to work.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

signal interaction_started(area: InteractionArea)
signal interaction_finished

var active_areas: Array[InteractionArea] = []
var current_area: InteractionArea
var _busy: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

#enable or disable the interaction manager on menus
func set_active(active: bool) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT if active else Node.PROCESS_MODE_DISABLED
	if not active:
		active_areas.clear()
		current_area = null
		_busy = false

#if a player enters a interaction area it gets stored and added to the active areas, used to allow a user to be in multiple interaction areas
func register_area(area: InteractionArea) -> void:
	if not active_areas.has(area):
		active_areas.append(area)

#if a player leaves a interaction area it gets removed from the active areas
func unregister_area(area: InteractionArea) -> void:
	active_areas.erase(area)
	if current_area == area:
		current_area = null

func _process(_delta: float) -> void:
	_refresh_target()

#function to find the interaction area that is closest to the player
func _refresh_target() -> void:
	current_area = null
	if _busy or get_tree().paused or Dialogic.current_timeline != null:
		return
	var closest_distance: float = INF
	for area in active_areas:
		var distance: float = area.global_position.distance_squared_to(area.get_player().global_position)
		if distance < closest_distance:
			current_area = area
			closest_distance = distance

#catches the interaction input key and locks the player from interacting again untill done
func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact"):
		return
	_refresh_target()
	if current_area == null:
		return
	var area: InteractionArea = current_area
	get_viewport().set_input_as_handled()
	_busy = true
	current_area = null
	interaction_started.emit(area)
	await area.activate()
	_busy = false
	interaction_finished.emit()
