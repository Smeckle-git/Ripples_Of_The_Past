extends HBoxContainer

class_name InputKeyRow

@onready var name_label = $HBoxContainer3/Name
@onready var button_1 = $HBoxContainer2/Button1
@onready var button_2 = $HBoxContainer2/Button2

signal rebind_request(action, slot, row: InputKeyRow)

var row_action: String

func setup(action: String, bindings: Array):
	row_action = action
	
	name_label.text = action.replace("_", " ").capitalize()
	
	button_1.focus_mode = Control.FOCUS_NONE
	button_2.focus_mode = Control.FOCUS_NONE
	
	button_1.text = "<unbound>"
	button_2.text = "<unbound>"
	
	if bindings[0] != null:
		button_1.text = bindings[0].as_text()
	if bindings[1] != null:
		button_2.text = bindings[1].as_text()

func _on_button_1_button_down() -> void:
	rebind_request.emit(row_action, 0, self)

func _on_button_2_button_down() -> void:
	rebind_request.emit(row_action, 1, self)
