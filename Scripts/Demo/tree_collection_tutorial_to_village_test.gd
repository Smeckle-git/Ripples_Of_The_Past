extends Node3D

@export_group("trees")
@export var tree_1: PackedScene
@export var tree_2: PackedScene
@export var tree_3: PackedScene
@export var tree_4: PackedScene

#@export var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_child_count() == 0:
		#print_debug("no children")
		return
	#
	#print_debug("children: ", get_child_count())
	var tree
	for i in get_child_count():
		match i%4:
			1:
				tree = tree_1.instantiate()
			2:
				tree = tree_2.instantiate()
			3:
				tree = tree_3.instantiate()
			0:
				tree = tree_4.instantiate()
		#
		tree.position = get_child(i).position
		#tree.rotation = camara.rotation
		if i%4 != 1:
			tree.scale = Vector3(0.5, 0.5, 0.5)
		#
		#var random = randf_range(0.8, 1.2)
		#tree.scale *= random
		#
		add_child(tree)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
