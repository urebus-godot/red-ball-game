class_name SpritesComponent extends Node

@export var creature: Creature
@export var body_sprite: Sprite2D


func _process(delta: float) -> void:
	body_sprite.rotation = -creature.rotation
