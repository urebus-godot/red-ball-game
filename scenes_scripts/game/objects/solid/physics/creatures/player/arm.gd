extends Node2D

const MAX_HIT_CHARGE: float = 2.25
const HIT_FORCE: float = 900

@export var player: Player
@export var life_component: LifeComponent

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var hits_enabled: bool = true
var is_holding_hit: bool = false
var can_charge_hit: bool = true
var rotating: bool = true
var is_hitting: bool = false

var hit_charge: float = 0.0


func hit() -> void:
	rotating = false
	is_holding_hit = false
	animation_player.play("hit")
	is_hitting = true

	await animation_player.animation_finished

	animation_player.play("RESET")
	is_hitting = false
	can_charge_hit = true
	hit_charge = 0.0
	rotating = true


func set_properties_to_players() -> void:
	scale = player.scale
	modulate = player.modulate

	if life_component.alive and rotating:
		var mouse_pos = get_global_mouse_position()
		var direction = position.direction_to(mouse_pos)
		var offset = ((mouse_pos - position) / 15).clampf(-35, 35)

		position = player.position + offset

		rotation = direction.angle()
	else:
		position = player.position


func accumulate_hit_charge(delta: float) -> void:
	if not hits_enabled: return
	if is_holding_hit and can_charge_hit:
		hit_charge += delta * 1.5
		if hit_charge > MAX_HIT_CHARGE:
			animation_player.play("charged")
			can_charge_hit = false


func _process(delta: float) -> void:
	set_properties_to_players()
	accumulate_hit_charge(delta)


func _input(event: InputEvent) -> void:
	if not hits_enabled: return
	if Input.is_action_just_pressed("hit") and not is_hitting:
		is_holding_hit = true

	if Input.is_action_just_released("hit"):
		hit()


func _on_arm_area_body_entered(body: Node2D) -> void:
	if body is PhysicsObject and is_hitting:
		if body is Creature:
			body.get_hit()
		else:
			var force = Vector2.from_angle(rotation) * (HIT_FORCE + hit_charge * HIT_FORCE)
			body.apply_central_impulse(force)
