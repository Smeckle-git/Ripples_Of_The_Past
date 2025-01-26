extends Control
class_name questupdate_canvas

@onready var quest_update: Label = $MarginContainer/Label
@onready var quest_start: Label = $MarginContainer/Label2
@onready var quest_finished: Label = $MarginContainer/Label3

var label : Label

func _ready() -> void:
	quest_update.visible = false
	quest_start.visible = false
	quest_finished.visible = false

func show_and_hide(status : String, content : String) -> void:
	if status == "started":
		label = quest_start
		label.text = content
	elif status == "updated":
		label = quest_update
		label.text = content
	elif status == "completed":
		label = quest_finished
		label.text = content
		
	if label:
		label.visible = true
		await get_tree().create_timer(1.5).timeout  # Wait for 3 seconds (adjust duration as needed)
		label.visible = false  # Hide the label again
