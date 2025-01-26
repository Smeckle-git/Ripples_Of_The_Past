extends StaticBody3D
class_name  Magic_tree

@onready var book: Sprite3D = $Sprite3D
@onready var no_book: Sprite3D = $Sprite3D2
@onready var interaction_area: InteractionArea = $InteractionArea

var has_book: bool = false

func switch_sprite():
	if has_book:
		has_book = false
		book.visible = false
		no_book.visible = true
	else:
		has_book = true
		book.visible = true
		no_book.visible = false
	
