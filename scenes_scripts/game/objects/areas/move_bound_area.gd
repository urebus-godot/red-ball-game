extends Area2D

@export var left_world_bound: CollisionShape2D
@export var right_world_bound: CollisionShape2D
@export var camera: Camera2D

@export var left_bound_offset: float
@export var right_bound_offset: float


func _on_body_entered(body: Node2D) -> void:
	if left_world_bound:
		left_world_bound.position.x += left_bound_offset
		camera.limit_left = left_world_bound.position.x
		print("Left Bound X: ", left_world_bound.position.x)

	if right_world_bound:
		right_world_bound.position.x += right_bound_offset
		camera.limit_right = left_world_bound.position.x

	queue_free()
