class_name LevelManager extends Node2D

signal level_finished(score: int)

@onready var ui_layer: CanvasLayer = $UILayer
@onready var background_layer: CanvasLayer = $BackgroundLayer
@onready var game_data: GameData = DataManager.game_data

@export var level: int = 1

var score: int = 1000

var is_level_finished: bool = false


func finish_level() -> void:
	is_level_finished = true
	if game_data.levels_completed < level:
		game_data.levels_completed += 1
	level_finished.emit(score)


func _ready() -> void:
	ui_layer.level = level
	background_layer.visible = true


func _on_finish_area_body_entered(body: Node2D) -> void:
	if not is_level_finished:
		finish_level()


func _on_player_died() -> void:
	pass # Replace with function body.
