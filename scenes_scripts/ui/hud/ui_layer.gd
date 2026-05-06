extends CanvasLayer

@onready var tinting: ColorRect = $Tinting
@onready var pause_menu: Control = $PauseMenu
@onready var options_menu: OptionsMenu = $OptionsMenu

var level: int = 1

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
	get_tree().paused = false
	TransitionScreen.change_scene(Constants.LEVEL_PATH % level)


func show_pause_menu() -> void:
	is_ui_free = false
	pause_menu.visible = true
	await tinting.show_tinting()
	is_ui_free = true


func hide_pause_menu() -> void:
	is_ui_free = false
	pause_menu.visible = false
	await tinting.hide_tinting()
	is_ui_free = true


func _ready() -> void:
	pause_menu.visible = false


func _input(event: InputEvent) -> void:
	if is_ui_free:
		if event.is_action_pressed("restart"):
			restart_level()
		elif event.is_action_pressed("pause"):
			check_for_pause()


func _on_resume_button_pressed() -> void:
	if is_ui_free:
		check_for_pause()

func _on_options_button_pressed() -> void:
	if is_ui_free:
		options_menu.show_menu()
		is_ui_free = false

func _on_restart_button_pressed() -> void:
	if is_ui_free:
		restart_level()

func _on_quit_button_pressed() -> void:
	if is_ui_free:
		get_tree().paused = false
		await TransitionScreen.change_scene(Constants.WORLD_PATH)

func _on_pause_button_pressed() -> void:
	if is_ui_free:
		check_for_pause()


func _on_options_menu_closed() -> void:
	is_ui_free = true


func _on_level_finished() -> void:
	tinting.show_tinting()
