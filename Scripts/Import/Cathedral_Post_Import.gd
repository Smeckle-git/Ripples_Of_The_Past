@tool
extends EditorScenePostImport

'''
!!!!!!!!!!!!!!!!!!!!!!!!!!!!	TO BE DELETED	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
AI made this for us, mby there's something wrong with the 3d model I made for the god room, but it didn't react well with the lights
the windows weren't transparent with the export, or at least didn't let light through.
this code seems to fix it, but I kinda want to see if I can make the model better instead.
I think this is a cool direction to make our version of the game head into, but if you prefer to keep the style we had I'm okay with that too.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'''

## White abyss panes stay visible but do not block the daylight behind them.
## Wall openings and all other room geometry retain their normal shadows.
func _post_import(scene: Node) -> Object:
	var window_count: int = _prepare_windows(scene)
	if window_count != 16:
		push_warning("Cathedral import: expected 16 abyss window panels, found %d." % window_count)
	return scene

func _prepare_windows(node: Node) -> int:
	var count: int = 0
	var node_name: String = str(node.name)
	var window_panel: bool = node_name.ends_with("_Inset") and (
		node_name.begins_with("Clerestory_")
		or node_name.begins_with("Left_Niche_")
		or node_name.begins_with("Right_Niche_")
	)
	if node is MeshInstance3D and window_panel:
		node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		count += 1
	for child in node.get_children():
		count += _prepare_windows(child)
	return count
