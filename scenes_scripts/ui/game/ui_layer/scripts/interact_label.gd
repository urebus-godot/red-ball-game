extends Label

const TWEEN_DURATION: float = 0.25

var START_POSITION: Vector2 = Vector2(960, 955)
var GOAL_POSITION: Vector2

var interact_key = SettingsDataManager.key_binding_settings["interact"]
var interact_text: String = "Press %s key to interact with %s"


func show_label(object_name: String) -> void:
	visible = true
	scale = Vector2.ZERO
	position = START_POSITION

	text = interact_text % [interact_key, object_name]

	var a_tween = create_tween().set_parallel()
	a_tween.tween_property(self, "modulate:a", 1.0, TWEEN_DURATION)

	var pos_tween = create_tween()
	pos_tween.tween_property(self, "position", GOAL_POSITION, TWEEN_DURATION)

	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE, TWEEN_DURATION)


func hide_label() -> void:
	var a_tween = create_tween().set_parallel()
	a_tween.tween_property(self, "modulate:a", 0.0, TWEEN_DURATION)

	var pos_tween = create_tween()
	pos_tween.tween_property(self, "position", START_POSITION, TWEEN_DURATION)

	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ZERO, TWEEN_DURATION)


func _ready() -> void:
	GOAL_POSITION = position
