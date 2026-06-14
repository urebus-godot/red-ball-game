extends CanvasLayer

const TWEEN_DURATION: float = 0.5

@onready var tinting: ColorRect = $Tinting
@onready var pause_menu: Control = $PauseMenu
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var finish_menu: Panel = $FinishMenu
@onready var lost_menu: Panel = $LostMenu

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


func show_finish_menu(score: int) -> void:
	var finish_info_label: Label = $FinishMenu/FinishInfoLabel
	finish_info_label.text = "You completed level %s! \nScore: %s" % [level, score]

	finish_menu.position.y = -900
	finish_menu.visible = true

	var tween = finish_menu.create_tween().set_trans(Constants.UI_TRANS_TYPE)
	var center_y = 144
	tween.tween_property(
		finish_menu, "position:y", center_y, TWEEN_DURATION
	)


func show_lost_menu() -> void:
	lost_menu.position.y = -900
	lost_menu.visible = true

	var tween = lost_menu.create_tween().set_trans(Constants.UI_TRANS_TYPE)
	var center_y = 144
	tween.tween_property(
		lost_menu, "position:y", center_y, TWEEN_DURATION
	)


func _ready() -> void:
	pause_menu.visible = false
	finish_menu.visible = false
	lost_menu.visible = false


func _input(event: InputEvent) -> void:
	if is_ui_free:
		if event.is_action_pressed("restart"):
			restart_level()
		elif event.is_action_pressed("pause"):
			check_for_pause()


func _on_level_finished(score: int) -> void:
	tinting.show_tinting()
	show_finish_menu(score)


func _on_player_died() -> void:
	await get_tree().create_timer(1.5).timeout
	tinting.show_tinting()
	show_lost_menu()


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

func _on_main_menu_button_pressed() -> void:
	if is_ui_free:
		await TransitionScreen.change_scene(Constants.WORLD_PATH)

func _on_next_level_button_pressed() -> void:
	if is_ui_free:
		await TransitionScreen.change_scene(Constants.LEVEL_PATH % level)


func _on_options_menu_closed() -> void:
	is_ui_free = true
