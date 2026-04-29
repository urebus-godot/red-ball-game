class_name OptionsMenu extends Panel

signal closed

const START_POSITION_Y: float = -800
const END_POSITION_Y: float  = 1200
const TWEEN_DURATION: float = 0.25

var is_ui_free: bool = false


func show_menu() -> void:
	is_ui_free = false
	position.y = START_POSITION_Y
	var tween = create_tween().set_trans(Constants.TRANS_TYPE)
	var center = 540.0 - size.y / 2.0
	tween.tween_property(
		self, "position:y", center, TWEEN_DURATION
	)
	await tween.finished
	is_ui_free = true


func hide_menu() -> void:
	is_ui_free = false
	var tween = create_tween().set_trans(Constants.TRANS_TYPE)
	tween.tween_property(
		self, "position:y", END_POSITION_Y, TWEEN_DURATION
	)
	await tween.finished


func _ready() -> void:
	position.y = START_POSITION_Y


func _on_close_button_pressed() -> void:
	if is_ui_free:
		closed.emit()
		await hide_menu()
