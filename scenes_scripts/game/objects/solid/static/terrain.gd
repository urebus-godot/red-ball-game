extends StaticBody2D

@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var ground_polygon: Polygon2D = $Polygon2D
@onready var ground_bounds: Path2D = $Path2D
@onready var ground_line: Line2D = $Line2D

@export var areas_without_grass: Array[Vector2] ## X of Vector is left bound; Y of Vector is right bound of area without grass 
@export var lower_ground: bool = false

@export var y_offset: float


func _ready() -> void:
	if lower_ground:
		position.y -= 64

	var ground_curve: Curve2D = ground_bounds.curve
	var ground_points: PackedVector2Array = ground_curve.get_baked_points()

	ground_polygon.polygon = ground_points
	ground_line.points = ground_points
	collision_polygon.polygon = ground_points

	var line_points = ground_line.get_points()
	var new_points = []
	var width = y_offset#(ground_line.width / 2) - 4
##s
	for point in line_points:
		new_points.append(point + Vector2(0, width))
##
	ground_line.set_points(new_points)
