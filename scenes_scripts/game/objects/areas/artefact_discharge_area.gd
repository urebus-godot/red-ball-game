extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var artefact = body.equipped_artefact
		if artefact:
			artefact.charged = false
