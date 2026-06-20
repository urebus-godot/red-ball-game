extends Area2D

@export var ui_layer: GameUILayer


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var artefact = body.equipped_artefact
		if artefact:
			artefact.charged = false


func _ready() -> void:
	if ui_layer:
		body_entered.connect(ui_layer._on_artefact_discharged)
