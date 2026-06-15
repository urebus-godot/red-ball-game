class_name PickableComponent extends Node

const TWEEN_DUR: float = 0.3

@export var target: Node2D


func fade_in() -> void:
	var pos_tween = target.create_tween().set_parallel()
	var goal_pos_y = target.position.y + 10
	
	pos_tween.tween_property(target, "position:y", goal_pos_y, TWEEN_DUR)

	var alpha_tween = target.create_tween()
	alpha_tween.tween_property(target, "modulate:a", 1.0, TWEEN_DUR)

	await alpha_tween.finished


func fade_out() -> void:
	var pos_tween = target.create_tween().set_parallel()
	var goal_pos_y = target.position.y - 60
	
	pos_tween.tween_property(target, "position:y", goal_pos_y, TWEEN_DUR)

	var alpha_tween = target.create_tween()
	alpha_tween.tween_property(target, "modulate:a", 0.0, TWEEN_DUR)

	await alpha_tween.finished

	queue_free()


func _on_area_body_entered(body: Node2D) -> void:
	fade_out()
