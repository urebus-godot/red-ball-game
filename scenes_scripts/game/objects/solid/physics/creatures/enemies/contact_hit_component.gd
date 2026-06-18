class_name ContactHitComponent extends Node

@export var enemy: Enemy


func _ready() -> void:
	enemy.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node):
	if body is Player:
		body.get_hit()
