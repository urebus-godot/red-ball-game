extends CanvasLayer

const START_TWEEN_POSITION_X: float = -280
const END_TWEEN_POSITION_X: float = 2600
const START_POSITION_X: float = START_TWEEN_POSITION_X - END_TWEEN_POSITION_X
const TWEEN_DURATION: float = 0.26
const START_TWEEN_DURATION: float = 0.5

@onready var panel: Panel = $Panel
@onready var start_screen: ColorRect = $StartScreen
@onready var black_screen: ColorRect = $StartScreen/BlackScreen

@export var do_show_start_screen: bool = true


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


func show_panel() -> void:
	start_screen.visible = false
	panel.position.x = END_TWEEN_POSITION_X
	panel.visible = true


func show_start_screen() -> void:
	panel.visible = false

	var show_tween = black_screen.create_tween()
	show_tween.tween_property(black_screen, "modulate:a", 0.0, START_TWEEN_DURATION)
	await get_tree().create_timer(START_TWEEN_DURATION * 1.6).timeout

	MusicPlayer.play_soundtrack(MusicPlayer.Soundtrack.MAIN_MENU, true)

	var hide_tween = start_screen.create_tween()
	hide_tween.tween_property(start_screen, "modulate:a", 0.0, START_TWEEN_DURATION)

	await hide_tween.finished

	show_panel()


func change_scene(path: String) -> void:
	await start_trans()
	get_tree().change_scene_to_file(path)
	end_trans()


func _ready() -> void:
	if do_show_start_screen:
		await get_tree().create_timer(0.5).timeout
		show_start_screen()
	else:
		show_panel()
		MusicPlayer.play_soundtrack(MusicPlayer.Soundtrack.MAIN_MENU, true)
