extends Node2D

const MAX_HIT_CHARGE: float = 2.25
const HIT_FORCE: float = 900

@export var player: Player
@export var life_component: LifeComponent

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_holding_hit: bool = false
var can_charge_hit: bool = true
var is_hitting: bool = false

var hit_charge: float = 0.0


func hit() -> void:
	is_holding_hit = false
	animation_player.play("hit")
	is_hitting = true

	await animation_player.animation_finished

	animation_player.play("RESET")
	is_hitting = false
	can_charge_hit = true
	hit_charge = 0.0


func set_position_and_rotation() -> void:
	if life_component.alive:
		var mouse_pos = get_global_mouse_position()
		var direction = position.direction_to(mouse_pos)
		var offset = ((mouse_pos - position) / 15).clampf(-35, 35)

		position = player.position + offset

		if not is_hitting:
			rotation = direction.angle()
	else:
		position = player.position


func accumulate_hit_charge(delta: float) -> void:
	if is_holding_hit and can_charge_hit:
		print("Charging hit \n hit_charge=", hit_charge)
		hit_charge += delta * 1.5
		if hit_charge > MAX_HIT_CHARGE:
			print("Hit is charge to maximum \n hit_charge=", hit_charge)
			animation_player.play("charged")
			can_charge_hit = false


func _process(delta: float) -> void:
	set_position_and_rotation()
	accumulate_hit_charge(delta)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("hit") and not is_hitting:
		print("\n !!! Started charging hit !!! \n")
		is_holding_hit = true

	if Input.is_action_just_released("hit"):
		print("\n Hitting !!! \n")
		hit()


func _on_arm_area_body_entered(body: Node2D) -> void:
	print("Body detected in _on_arm_area_body_entered!")
	if body is PhysicsObject and is_hitting:
		var force = Vector2.from_angle(rotation) * (HIT_FORCE + hit_charge * HIT_FORCE)
		body.apply_central_impulse(force)
		print("Applying %s N to the %s" % [force, body.name])
