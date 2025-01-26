extends Control
class_name journal_icon_group

@onready var label: Label = $Label
@onready var label_2: Label = $Label2

func _ready() -> void:
		label_2.visible = false

func _process(_delta: float) -> void:
	label.text = GameSettingsManager.get_keybinding("Journal")
	

func on_quest_update():
	label_2.visible = true

func on_opening_journal():
	label_2.visible = false
