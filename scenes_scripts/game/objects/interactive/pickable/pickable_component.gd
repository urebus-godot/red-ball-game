class_name PickableComponent extends Node

@export var target: Node2D


func fade_out() -> void:
	var pos_tween = target.create_tween().set_parallel()
	var goal_pos_y = target.position.y - 60
	
	pos_tween.tween_property(target, "position:y", goal_pos_y, 0.3)

	var alpha_tween = target.create_tween()
	alpha_tween.tween_property(target, "modulate:a", 0.0, 0.3)

	await alpha_tween.finished

	queue_free()


func _on_area_body_entered(body: Node2D) -> void:
	fade_out()
