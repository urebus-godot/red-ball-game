class_name MoveComponent extends Node

@export var torque: float = 30000.0
@export var jump_force: float = 300.0

@export var creature: Creature
@export var floor_raycast: RayCast2D

var time_to_jump: float = 0.3


func is_on_floor() -> bool:
	return floor_raycast.is_colliding()


func move_right() -> void:
	creature.apply_torque(torque)

func move_left() -> void:
	creature.apply_torque(-torque)


func jump(delta: float) -> void:
	if is_on_floor():
		var impulse = Vector2.UP * jump_force
		creature.apply_central_impulse(impulse)
	elif time_to_jump > 0.0:
		time_to_jump -= delta


func _physics_process(delta: float) -> void:
	floor_raycast.position = creature.position
	if is_on_floor():
		time_to_jump = 0.3
