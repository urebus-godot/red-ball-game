class_name MoveComponent extends Node

#signal enter_floor

const HOLD_JUMP_TIME: float = 0.14
const FORCE_IN_AIR_MULTIPLIER: float = 0.006
const VELOCITY_TORQUE_RATIO: float = 0.018

@export var torque: float = 45000.0
@export var max_velocity: float = 800.0
@export var jump_impulse: float = 350.0
@export var jump_hold_force: float = 2600

@export var creature: Creature
@export var floor_raycast: RayCast2D

var time_to_jump: float = HOLD_JUMP_TIME
var velocity_multiplier: float = 1.0
var jump_impulse_multiplier: float = 1.0

var jump_enabled: bool = true
var movement_enabled: bool = true
var emitted_enter_floor_signal: bool = false


func is_on_floor() -> bool:
	return floor_raycast.is_colliding()


func is_in_air() -> bool:
	var bodies = creature.get_colliding_bodies()
	return len(bodies) == 0


func disable_jump() -> void:
	jump_enabled = false


#func emit_enter_floor_signal() -> void:
	#if is_on_floor() and not emitted_enter_floor_signal:
		#enter_floor.emit()
		#emitted_enter_floor_signal = true
		#print("Emitted enter_floor s!")
	#elif not is_on_floor():
		#emitted_enter_floor_signal = false


func move_right() -> void:
	if movement_enabled and creature.linear_velocity.x < (max_velocity * velocity_multiplier):
		creature.apply_torque(torque * velocity_multiplier)
		if is_in_air():
			creature.apply_central_force(Vector2.RIGHT * torque * FORCE_IN_AIR_MULTIPLIER * velocity_multiplier)

func move_left() -> void:
	if movement_enabled and abs(creature.linear_velocity.x) < (max_velocity * velocity_multiplier):
		creature.apply_torque(-torque * velocity_multiplier)
		if is_in_air():
			creature.apply_central_force(Vector2.LEFT * torque * FORCE_IN_AIR_MULTIPLIER * velocity_multiplier)

func jump(delta: float) -> void:
	if movement_enabled and jump_enabled:
		if is_on_floor():
			var impulse = Vector2.UP * jump_impulse * jump_impulse_multiplier
			creature.apply_central_impulse(impulse)
		elif time_to_jump > 0.0:
			time_to_jump -= delta
			var force = Vector2.UP * jump_hold_force * jump_impulse_multiplier
			creature.apply_central_force(force)


func _physics_process(delta: float) -> void:
	#emit_enter_floor_signal()
	floor_raycast.position = creature.position
	if is_on_floor():
		time_to_jump = HOLD_JUMP_TIME
		jump_enabled = true
