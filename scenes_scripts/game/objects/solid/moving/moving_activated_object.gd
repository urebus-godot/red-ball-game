extends ActivatedObject

@export var start_pos: Vector2
@export var goal_offset: Vector2

@export var tween_duration: float = 0

func activate() -> void:
	await super()
	var tween = create_tween()
	tween.tween_property(self, "position", start_pos + goal_offset, tween_duration)


func deactivate() -> void:
	await super()
	var tween = create_tween()
	tween.tween_property(self, "position", start_pos, tween_duration)


func _ready() -> void:
	start_pos = position
	if not tween_duration:
		tween_duration = (start_pos - goal_offset).length() / 50
