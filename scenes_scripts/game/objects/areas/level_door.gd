extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	animated_sprite.play("open")

func _on_body_exited(body: Node2D) -> void:
	animated_sprite.play("close")
