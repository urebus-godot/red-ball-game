class_name OptionsMenu extends Panel

signal closed

const START_POSITION_Y: float = -800
const END_POSITION_Y: float  = 1200
const TWEEN_DURATION: float = 0.25
const MIN_DB: float = -60
const MAX_DB: float = 0.0

@onready var music_volume_slider: HSlider = $Control/VBoxContainer/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $Control/VBoxContainer/SFXVolumeSlider

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


func sync_sliders() -> void:
	music_volume_slider.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_volume_slider.value = db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))


func slider_to_db(value: float) -> float:
	if value <= 0.0:
		return MIN_DB
	var linear = value / 100.0
	var db = linear_to_db(linear)
	return db


func db_to_slider(value: float) -> float:
	var slider_value = db_to_linear(value) * 100.0
	return slider_value


func set_volume(bus_name: String, value: float, key: String) -> void:
	var db = slider_to_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)

	AudioServer.set_bus_volume_db(bus_index, db)
	AudioServer.set_bus_mute(bus_index, db <= MIN_DB)

	var linear_value = clampf(value / 100.0, 0.0, 1.0)
	SettingsDataManager.audio_settings[key] = linear_value


func _ready() -> void:
	visible = true
	position.y = START_POSITION_Y


func _on_close_button_pressed() -> void:
	if is_ui_free:
		closed.emit()
		await hide_menu()


func _on_music_volume_slider_value_changed(value: float) -> void:
	set_volume("Music", value, "music_volume")

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	set_volume("SFX", value, "sfx_volume")
