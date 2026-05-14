extends Node2D

const MAX_HIT_CHARGE: float = 3.0
const MIN_HIT_FORCE: float = 3000

@export var player: Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_holding_hit: bool = false
var can_charge_hit: bool = false
var is_hitting: bool = false

var hit_charge: float = 0.0


func hit() -> void:
	is_holding_hit = false
	animation_player.play("hit")
	is_hitting = true

	await animation_player.animation_finished

	is_hitting = false
	can_charge_hit = true
	hit_charge = 0.0


func set_position_and_rotation() -> void:
	position = player.position

	if not is_hitting:
		var mouse_pos = get_global_mouse_position()
		var direction = position.direction_to(mouse_pos)
		var rotation_lerp = lerpf(rotation, direction.angle(), 0.4)

		rotation = rotation_lerp


func accumulate_hit_charge(delta: float) -> void:
	if is_holding_hit and can_charge_hit:
		hit_charge += delta * 1.5
		if hit_charge > MAX_HIT_CHARGE:
			can_charge_hit = false


func _process(delta: float) -> void:
	set_position_and_rotation()
	accumulate_hit_charge(delta)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("hit") and not is_hitting:
		is_holding_hit = true

	if Input.is_action_just_released("hit"):
		hit()


func _on_arm_area_body_entered(body: Node2D) -> void:
	print("Body detected in _on_arm_area_body_entered!")
	if body is PhysicsObject and is_hitting:
		var force = Vector2.from_angle(rotation) * (MIN_HIT_FORCE + hit_charge * MIN_HIT_FORCE)
		body.apply_central_impulse(force)
		print("Applying %s N to the %s" % [force, body.name])
