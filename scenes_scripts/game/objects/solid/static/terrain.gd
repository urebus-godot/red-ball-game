extends StaticBody2D

@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var ground_polygon: Polygon2D = $Polygon2D
@onready var ground_bounds: Path2D = $Path2D
@onready var ground_line: Line2D = $Line2D


func _ready() -> void:
	var ground_curve: Curve2D = ground_bounds.curve
	var ground_points: PackedVector2Array = ground_curve.get_baked_points()

	ground_polygon.polygon = ground_points
	ground_line.points = ground_points
	collision_polygon.polygon = ground_points

	var line_points = ground_line.get_points()
	var new_points = []
	var width = (ground_line.width / 2) - 4

	for point in line_points:
		new_points.append(point + Vector2(0, width))

	ground_line.set_points(new_points)
