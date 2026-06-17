extends Area2D

@onready var spiral_sprite: Sprite2D = $SpiralSprite


func _process(delta: float) -> void:
	spiral_sprite.rotation_degrees += Constants.SPIRAL_ROTATION_SPEED
