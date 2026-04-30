extends CanvasLayer

const START_TWEEN_POSITION_X: float = -280
const END_TWEEN_POSITION_X: float = 2600
const START_POSITION_X: float = START_TWEEN_POSITION_X - END_TWEEN_POSITION_X
const TWEEN_DURATION: float = 0.26

@onready var panel: Panel = $Panel


func start_trans() -> void:
	panel.position.x = START_POSITION_X
	var tween = panel.create_tween()
	tween.tween_property(panel, "position:x", START_TWEEN_POSITION_X, TWEEN_DURATION)
	await tween.finished

func end_trans() -> void:
	panel.position.x = START_TWEEN_POSITION_X
	var tween = panel.create_tween()
	tween.tween_property(panel, "position:x", END_TWEEN_POSITION_X, TWEEN_DURATION)
	await tween.finished


func change_scene(path: String) -> void:
	await start_trans()
	get_tree().change_scene_to_file(path)
	end_trans()


func _ready() -> void:
	end_trans()
