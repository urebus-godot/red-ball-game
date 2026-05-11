extends Node2D

const COLLISION_OFFSET: Vector2 = Vector2(0, -76.0)

@onready var water_area: Area2D = $WaterArea
@onready var collision_shape: CollisionShape2D = $WaterArea/CollisionShape
@onready var water_texture: TextureRect = $WaterTexture


func _ready() -> void:
	water_area.position = (water_texture.size / 2) + COLLISION_OFFSET
	collision_shape.shape.size = water_texture.size


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
