extends ActivatedObject

@export var start_pos: Vector2
@export var goal_pos: Vector2

@export var tween_duration: float

func activate() -> void:
	await super()
	var tween = create_tween()
	tween.tween_property(self, "position", goal_pos, tween_duration)


func deactivate() -> void:
	await super()
	var tween = create_tween()
	tween.tween_property(self, "position", goal_pos, tween_duration)


func _ready() -> void:
	if not tween_duration:
		tween_duration = (start_pos - goal_pos).length() / 240
