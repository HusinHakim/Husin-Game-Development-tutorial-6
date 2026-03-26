extends CanvasLayer

var _overlay: ColorRect
var _tween: Tween

func _ready() -> void:
	layer = 100
	process_mode = Node.PROCESS_MODE_ALWAYS

	_overlay = ColorRect.new()
	_overlay.color = Color(0, 0, 0, 0)
	_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_overlay)

func change_scene(path: String) -> void:
	await _fade(1.0)
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await _fade(0.0)

func _fade(alpha: float) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_overlay, "color:a", alpha, 0.4)
	await _tween.finished
