extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func show_self() -> void:
	self.visible = true
	
func hide_self() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Journal") and !get_tree().paused:
		show_self()

	elif Input.is_action_just_pressed("Journal") and get_tree().paused:
		hide_self()
		
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		show_self()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		hide_self()
	
