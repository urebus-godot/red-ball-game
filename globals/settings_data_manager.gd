extends Node

const SETTINGS_DATA_PATH: String = "user://settings_data.cfg"

var audio_settings: Dictionary[String, float] = {
	"music_volume": 0.75,
	"sfx_volume": 0.75,
}

var key_binding_settings: Dictionary[String, String] = {
	"interact": "E",
	"restart": "P"
}


func save_settings() -> void:
	var config_file = ConfigFile.new()

	for key in audio_settings:
		config_file.set_value("audio", key, audio_settings[key])

	var error = config_file.save(SETTINGS_DATA_PATH)

	if error != OK:
		prints("An error occured during seving settings:", error)
	else:
		print("Settings saved!")


func load_settings() -> void:
	var config_file = ConfigFile.new()
	var error = config_file.load(SETTINGS_DATA_PATH)
	
	if error != OK:
		prints("An error occured during loading settings:", error)
		return

	for section in ["audio"]:
		if not config_file.has_section(section):
			continue

		var target_dict: Dictionary = get(section + "_settings")
		for key in target_dict.keys():
			if config_file.has_section_key(section, key):
				target_dict[key] = config_file.get_value(section, key)
		
	print("Settings are loaded!")


func apply_audio_settings() -> void:
	var music_db = linear_to_db(clamp(audio_settings["music_volume"], 0.0, 1.0))
	var sfx_db = linear_to_db(clamp(audio_settings["sfx_volume"], 0.0, 1.0))

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_db)

	#assert(
		#is_equal_approx(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")), music_db),
		#"bus music volume: %s; settings music volume: %s" 
		#% [AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")), music_db]
		#)
	#assert(
		#is_equal_approx(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")), sfx_db),
		#"bus sfx volume: %s; settings sfx volume: %s" 
		#% [AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")), sfx_db]
		#)
	print("Audio settings are applied!")


func _ready() -> void:
	load_settings()
	apply_audio_settings()
