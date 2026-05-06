class_name MoveComponent extends Node

#signal enter_floor

const HOLD_JUMP_TIME: float = 0.14

@export var torque: float = 40000.0
@export var angular_velocity: float = 11.0
@export var jump_impulse: float = 350.0
@export var jump_hold_force: float = 2600

@export var creature: Creature
@export var floor_raycast: RayCast2D

var time_to_jump: float = HOLD_JUMP_TIME

var jump_enabled: bool = true
var movement_enabled: bool = true
var emitted_enter_floor_signal: bool = false


func is_on_floor() -> bool:
	return floor_raycast.is_colliding()


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
	if movement_enabled and creature.angular_velocity < angular_velocity:
		creature.apply_torque(torque)

func move_left() -> void:
	if movement_enabled and abs(creature.angular_velocity) < angular_velocity:
		creature.apply_torque(-torque)


func jump(delta: float) -> void:
	if jump_enabled and movement_enabled:
		if is_on_floor():
			var impulse = Vector2.UP * jump_impulse
			creature.apply_central_impulse(impulse)
		elif time_to_jump > 0.0:
			time_to_jump -= delta
			var force = Vector2.UP * jump_hold_force
			creature.apply_central_force(force)


func _physics_process(delta: float) -> void:
	#emit_enter_floor_signal()
	floor_raycast.position = creature.position
	if is_on_floor():
		time_to_jump = HOLD_JUMP_TIME
		jump_enabled = true
