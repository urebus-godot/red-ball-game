class_name MoveComponent extends Node

const HOLD_JUMP_TIME: float = 0.16

@export var torque: float = 30000.0
@export var jump_impulse: float = 240.0
@export var jump_hold_force: float = 1600

@export var creature: Creature
@export var floor_raycast: RayCast2D

var time_to_jump: float = HOLD_JUMP_TIME
var jump_enabled: bool = true


func is_on_floor() -> bool:
	return floor_raycast.is_colliding()

func disable_jump() -> void:
	jump_enabled = false


func move_right() -> void:
	creature.apply_torque(torque)

func move_left() -> void:
	creature.apply_torque(-torque)


func jump(delta: float) -> void:
	if jump_enabled:
		if is_on_floor():
			var impulse = Vector2.UP * jump_impulse
			creature.apply_central_impulse(impulse)
		elif time_to_jump > 0.0:
			time_to_jump -= delta
			var force = Vector2.UP * jump_hold_force
			creature.apply_central_force(force)


func _physics_process(delta: float) -> void:
	floor_raycast.position = creature.position
	if is_on_floor():
		time_to_jump = HOLD_JUMP_TIME
		jump_enabled = true
