class_name MoveComponent extends Node

@export var torque: float = 30000.0
@export var jump_force: float = 3000.0

@export var creature: Creature


func move_right() -> void:
	creature.apply_torque(torque)

func move_left() -> void:
	creature.apply_torque(-torque)


func jump() -> void:
	var impulse = Vector2.UP * jump_force
	creature.apply_central_impulse(impulse)
