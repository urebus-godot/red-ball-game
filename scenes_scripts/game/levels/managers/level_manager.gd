class_name LevelManager extends Node2D

signal level_finished(score: int, time_s: float)

@onready var game_data: GameData = DataManager.game_data

@onready var background_layer: CanvasLayer = $BackgroundLayer
@onready var player: Player = $Objects/Creatures/Player 

@onready var ui_layer: GameUILayer = $UILayer

@onready var topazes_parent: Node2D = $Objects/Pickables/Topazes
@onready var interactive_objects_parent: Node2D = $Objects/Interactive

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
	print(game_data.levels_completed)
	DataManager.save_data()
	level_finished.emit(score, time_passed_s)


func connect_interactive_object_signals(parent: Node) -> void:
	print("Start connection of objects ", parent.get_children())
	for obj in parent.get_children():
		if not obj.player_entered.has_connections():
			obj.player_entered.connect(player._on_interactive_object_player_entered)
			obj.player_exited.connect(player._on_interactive_object_player_exited)

			obj.player_entered.connect(ui_layer._on_interactive_object_player_entered)
			obj.player_exited.connect(ui_layer._on_interactive_object_player_exited)


func _ready() -> void:
	ui_layer.level = level
	background_layer.visible = true
	
	for t in topazes_parent.get_children():
		t.topaz_collected.connect(_on_topaz_collected)

	connect_interactive_object_signals(interactive_objects_parent)

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
