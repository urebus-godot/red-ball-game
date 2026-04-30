extends CanvasLayer

@onready var tinting: ColorRect = $Tinting
@onready var pause_menu: Control = $PauseMenu

@export var level: int = 1

var is_ui_free: bool = true


func check_for_pause() -> void:
	if not get_tree().paused:
		pause_game()
	else:
		unpause_game()


func pause_game() -> void:
	get_tree().paused = true
	show_pause_menu()

func unpause_game() -> void:
	get_tree().paused = false
	hide_pause_menu()


func restart_level() -> void:
	is_ui_free = false
	TransitionScreen.change_scene(Constants.LEVEL_PATH % level)


func show_pause_menu() -> void:
	is_ui_free = false
	pause_menu.visible = true
	await tinting.show_tinted_background()
	is_ui_free = true

func hide_pause_menu() -> void:
	is_ui_free = false
	pause_menu.visible = false
	await tinting.hide_tinted_background()
	is_ui_free = true


func _input(event: InputEvent) -> void:
	if is_ui_free:
		if event.is_action_pressed("restart"):
			restart_level()
		elif event.is_action_pressed("pause"):
			check_for_pause()
