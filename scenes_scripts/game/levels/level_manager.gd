class_name LevelManager extends Node2D

signal level_finished(score: int)

@onready var ui_layer: UILayer = $UILayer
@onready var background_layer: CanvasLayer = $BackgroundLayer
@onready var game_data: GameData = DataManager.game_data

@export var topazes_location: Node2D

@export var level: int = 1

var time_passed_s: float = 0.0
var score: int = 1000
var topazes_collected: int = 0:
	set(value):
		topazes_collected = value
		ui_layer.set_topaz_label_value(value)

var is_level_finished: bool = false


func finish_level() -> void:
	is_level_finished = true
	if game_data.levels_completed < level:
		game_data.levels_completed += 1
	level_finished.emit(score, time_passed_s)


func _ready() -> void:
	ui_layer.level = level
	background_layer.visible = true
	
	for t in topazes_location.get_children():
		print(t.name)
		t.topaz_collected.connect(_on_topaz_collected)

	ui_layer.set_topaz_label_value(0)


func _process(delta: float) -> void:
	if not is_level_finished:
		time_passed_s += delta


func _on_finish_area_body_entered(body: Node2D) -> void:
	if not is_level_finished:
		finish_level()


func _on_topaz_collected() -> void:
	topazes_collected += 1


func _on_player_died() -> void:
	pass # Replace with function body.
