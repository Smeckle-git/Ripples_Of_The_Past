extends CanvasLayer

@onready var prompt: PanelContainer = $Prompt
@onready var label: Label = $Prompt/Label

func _ready() -> void:
	InteractionManager.set_active(true)

func _exit_tree() -> void:
	InteractionManager.set_active(false)

func _process(_delta: float) -> void:
	var area: InteractionArea = InteractionManager.current_area
	if area == null:
		prompt.hide()
		return
	prompt.visible = area.show_label

	# Project the interaction's position onto the screen.
	var camera: Camera3D = get_viewport().get_camera_3d()
	var anchor: Vector3 = area.global_position + area.prompt_offset
	if camera == null or camera.is_position_behind(anchor):
		prompt.hide()
		return

	label.text = "[%s] to %s" % [SettingsManager.get_setting("keybinding", "interact")[0].as_text(), area.action_name]
	var size_on_canvas: Vector2 = prompt.size * prompt.scale
	var screen_anchor: Vector2 = camera.unproject_position(anchor)
	prompt.position = screen_anchor - size_on_canvas * 0.5
