extends ColorRect

const TWEEN_DURATION: float = 0.22


func show_tinting() -> void:
	visible = true
	var tween = create_tween().tween_property(
		self, "color:a", 0.4, TWEEN_DURATION
	)


func hide_tinting() -> void:
	var tween = create_tween().tween_property(
		self, "color:a", 0.0, TWEEN_DURATION
	)
	await tween.finished
	visible = false
