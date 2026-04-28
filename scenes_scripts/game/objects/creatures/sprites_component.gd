class_name SpritesComponent extends Node

@export var creature: Creature
@export var body_animated_sprite: AnimatedSprite2D


func _process(delta: float) -> void:
	body_animated_sprite.rotation = -creature.rotation
