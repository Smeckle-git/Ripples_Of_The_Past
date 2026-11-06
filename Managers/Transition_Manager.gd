extends CanvasLayer

"""
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
all this is for to make smooth transitions between scenes and screens.

just a always active overlay that has 2 difrent animations we can play.
I want to use the fade to start interactions because these are fast and we don't need to laod anything.
And the cool diamond shader animation Vicent made for laoding is still in here aswell.

Laura, lmk what you think is better UX, this is your expertise. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""

@export var diamond_duration: float = 1.5
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fade_overlay: ColorRect = $ColorRect
@onready var diamond_overlay: ColorRect = $DiamondOverlay
@onready var loading_screen: Control = $LoadingScreen
var is_transitioning: bool = false

#plays the fade animation
func play_transition(name: String) -> void:
	if is_transitioning:
		return
	is_transitioning = true
	animation_player.play(name)
	await animation_player.animation_finished
	is_transitioning = false

#play the cool animation we had to transition screens with loading screen and back
func cover_for_loading() -> void:
	is_transitioning = true
	diamond_overlay.material.set_shader_parameter("progress", 0.0)
	diamond_overlay.show()
	var tween: Tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(diamond_overlay.material, "shader_parameter/progress", 1.0, diamond_duration)
	await tween.finished
	loading_screen.call("start")

func reveal_after_loading() -> void:
	loading_screen.hide()
	var tween: Tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(diamond_overlay.material, "shader_parameter/progress", 0.0, diamond_duration)
	await tween.finished
	diamond_overlay.hide()
	is_transitioning = false
