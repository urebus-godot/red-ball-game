extends Line2D

@export var left_point: Node2D
@export var right_point: Node2D


func _process(delta: float) -> void:
	if not (left_point and right_point):
		return
	points = [left_point.position, right_point.position]
