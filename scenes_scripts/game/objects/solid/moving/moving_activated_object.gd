extends ActivatedObject

const TRANS_TYPE = Tween.TRANS_CUBIC

@export var start_pos: Vector2
@export var goal_offset: Vector2

@export var tween_duration: float = 0

func activate() -> void:
	await super()
	var tween = create_tween().set_trans(TRANS_TYPE)
	tween.tween_property(self, "position", start_pos + goal_offset, tween_duration)


func deactivate() -> void:
	await super()
	var tween = create_tween().set_trans(TRANS_TYPE)
	tween.tween_property(self, "position", start_pos, tween_duration)


func _ready() -> void:
	start_pos = position
	if not tween_duration:
		tween_duration = (start_pos - goal_offset).length() / 600
