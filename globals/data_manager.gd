extends Node

const GAME_DATA_PATH: String = "user://game_data.tres"


var game_data: GameData = null


func save_data() -> void:
	var err = ResourceSaver.save(game_data, GAME_DATA_PATH)
	if err != OK:
		printerr("Error occurred during saving data: \n", err)


func load_data() -> void:
	if data_exists():
		ResourceLoader.load(GAME_DATA_PATH, "GameData", ResourceLoader.CACHE_MODE_IGNORE)


func data_exists() -> bool:
	return ResourceLoader.exists(GAME_DATA_PATH)


func reset_data() -> void:
	game_data = GameData.new()


func _init() -> void:
	game_data = GameData.new()
