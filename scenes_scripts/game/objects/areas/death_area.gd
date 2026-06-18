extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Creature:
		body.life_component.die(false)
