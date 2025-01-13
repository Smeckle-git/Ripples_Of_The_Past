extends Node3D


@export var tree_1_prefab: PackedScene
@export var tree_2_prefab: PackedScene

func _ready() -> void:
	spawnPrefabs()


func spawnPrefabs():
	for child in self.get_children():
		if child is Marker3D:
			var tree = tree_1_prefab.instantiate()
			
			tree.position = child.position
			tree.rotation = child.rotation
			add_child(tree)
