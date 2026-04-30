extends CanvasLayer

const START_TWEEN_POSITION: float = -280
const END_TWEEN_POSITION: float = 2600

@onready var panel: Panel = $Panel


func start_trans() -> void:
	var tween = panel.create_tween()
	tween.tween_property(panel, "position:x", START_TWEEN_POSITION, 0.4)
	await tween.finished

func end_trans() -> void:
	var tween = panel.create_tween()
	tween.tween_property(panel, "position:x", END_TWEEN_POSITION, 0.4)
	await tween.finished


func change_scene(path: String) -> void:
	await start_trans()
	get_tree().change_scene_to_file(path)
	end_trans()


func _ready() -> void:
	panel.position.x = -280
