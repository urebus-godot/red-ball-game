class_name MoveComponent extends Node

@export var torque: float = 30000.0
@export var jump_force: float = 3000.0

@export var creature: Creature
@export var floor_raycast: RayCast2D


func is_on_floor() -> bool:
	return floor_raycast.is_colliding()


func move_right() -> void:
	creature.apply_torque(torque)

func move_left() -> void:
	creature.apply_torque(-torque)


func jump() -> void:
	if is_on_floor():
		var impulse = Vector2.UP * jump_force
		creature.apply_central_impulse(impulse)


func _physics_process(delta: float) -> void:
	floor_raycast.position = creature.position
