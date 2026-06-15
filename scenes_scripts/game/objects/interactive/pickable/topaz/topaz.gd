extends Node2D

signal topaz_collected

var collected: bool = false


func _on_body_entered(body: Node2D) -> void:
	if not collected:
		collected = true
		topaz_collected.emit()
