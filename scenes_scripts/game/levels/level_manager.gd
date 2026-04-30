class_name LevelManager extends Node2D

@onready var ui_layer: CanvasLayer = $UILayer

@export var level: int = 1


func _ready() -> void:
	ui_layer.level = level
