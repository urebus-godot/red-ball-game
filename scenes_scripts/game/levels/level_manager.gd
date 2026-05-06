class_name LevelManager extends Node2D

signal level_finished

@onready var ui_layer: CanvasLayer = $UILayer
@onready var background_layer: CanvasLayer = $BackgroundLayer
@onready var game_data: GameData = DataManager.game_data

@export var level: int = 1


func finish_level() -> void:
	if game_data.levels_completed < level:
		game_data.levels_completed += 1


func _ready() -> void:
	ui_layer.level = level
	background_layer.visible = true


func _on_finish_area_body_entered(body: Node2D) -> void:
	finish_level()
