extends Control

@onready var start_menu: Control = $StartMenu
@onready var levels_menu: Control = $LevelsMenu
@onready var level_button_container: GridContainer = $LevelsMenu/LevelButtonContainer
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var tinting: ColorRect = $Tinting

var is_ui_free: bool = true

var game_data: GameData = DataManager.game_data


func show_levels_menu() -> void:
	var levels_menu_pos = (1920 - levels_menu.size.x) / 2
	var levels_menu_tween = levels_menu.create_tween().set_trans(Constants.TRANS_TYPE)
	levels_menu_tween.tween_property(levels_menu, "position:x", levels_menu_pos, Constants.TWEEN_DURATION)

	var start_menu_pos = ((1920 - levels_menu.size.x) / 2) - 1920
	var start_menu_tween = start_menu.create_tween().set_trans(Constants.TRANS_TYPE)
	start_menu_tween.tween_property(start_menu, "position:x", start_menu_pos, Constants.TWEEN_DURATION)

	await start_menu_tween.finished


func show_start_menu() -> void:
	var levels_menu_pos = ((1920 - levels_menu.size.x) / 2) + 1920
	var levels_menu_tween = levels_menu.create_tween().set_trans(Constants.TRANS_TYPE)
	levels_menu_tween.tween_property(levels_menu, "position:x", levels_menu_pos, Constants.TWEEN_DURATION)

	var start_menu_pos = (1920 - levels_menu.size.x) / 2
	var start_menu_tween = start_menu.create_tween().set_trans(Constants.TRANS_TYPE)
	start_menu_tween.tween_property(start_menu, "position:x", start_menu_pos, Constants.TWEEN_DURATION)
	
	await start_menu_tween.finished


func _ready() -> void:
	levels_menu.visible = true
	levels_menu.position.x = 2000
	DataManager.load_data()
	var i = 1
	for c in level_button_container.get_children():
		if c is Button:
			c.pressed.connect(_on_level_button_pressed.bind(i))
			i += 1


func _on_play_button_pressed() -> void:
	if is_ui_free:
		is_ui_free = false
		TransitionScreen.change_scene(Constants.WORLD_PATH)
		#await show_levels_menu()
		is_ui_free = true

func _on_quit_button_pressed() -> void:
	if is_ui_free:
		is_ui_free = false
		get_tree().quit()

func _on_level_button_pressed(level: int) -> void:
	if is_ui_free and game_data.levels_completed + 1 >= level:
		TransitionScreen.change_scene(Constants.LEVEL_PATH % level)

func _on_to_start_menu_button_pressed() -> void:
	if is_ui_free:
		is_ui_free = false
		await show_start_menu()
		is_ui_free = true

<<<<<<< HEAD
=======

>>>>>>> 58f34a40d761c99d5b5ba4bebbe57a98dfcd14b1
func _on_options_button_pressed() -> void:
	if is_ui_free:
		is_ui_free = false
		tinting.show_tinting()
		options_menu.show_menu()


func _on_options_menu_closed() -> void:
	tinting.hide_tinting()
	is_ui_free = true
