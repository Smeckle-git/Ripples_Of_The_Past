extends Control

@export_range(1.0, 30.0) var frames_per_second: float = 6.0
@onready var scale_sprite: Sprite2D = $Center/Content/ScaleHost/Scale
@onready var status: Label = $Center/Content/Status

const SWAY: Array[int] = [4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3]
var _elapsed: float = 0.0
var _step: int = 0

func _ready() -> void:
	var frame_size: Vector2 = scale_sprite.texture.get_size() / Vector2(3, 3)
	scale_sprite.scale = Vector2(264, 200) / frame_size

func start() -> void:
	_elapsed = 0.0
	_step = 0
	scale_sprite.frame = SWAY[0]
	status.text = "Loading..."
	show()

func _process(delta: float) -> void:
	if not is_visible_in_tree():
		return
	_elapsed += delta
	var frame_duration: float = 1.0 / frames_per_second
	while _elapsed >= frame_duration:
		_elapsed -= frame_duration
		_step = (_step + 1) % SWAY.size()
		scale_sprite.frame = SWAY[_step]
