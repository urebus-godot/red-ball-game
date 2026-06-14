@abstract class_name ActivatedObject extends Node2D

@export var activation_delay: float = 0.0

var is_activated: bool = false

func activate() -> void:
	await get_tree().create_timer(activation_delay).timeout
