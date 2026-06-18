class_name Player extends Creature

signal artefact_equipped(artefact: PickableArtefact)
signal artefact_unequipped(artefact: Artefact)

const SCALE_TWEEN_DURATION: float = 0.3

@onready var interact_timer: Timer = $InteractTimer
@onready var arm: Node2D = $Arm

@export var camera: Camera2D
@export var control_component: ControlComponent
@export var move_component: RoundMoveComponent
@export var free_camera_mode_enabled: bool = false

var can_interact: bool = true
var control_enabled: bool = true:
	set(value):
		control_enabled = value
		if not control_enabled:
			can_interact = false
			move_component.movement_enabled = false
			arm.rotating = false
			enable_arm(false)

var object_to_interact: InteractiveObject = null
var equipped_artefact: Artefact = null


func tween_scale(decrement: bool = false) -> void:
	var scale_tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	if decrement:
		scale_tween.tween_property(self, "scale", Vector2.ZERO, SCALE_TWEEN_DURATION)
	else:
		scale = Vector2.ZERO
		scale_tween.tween_property(self, "scale", Vector2.ONE, SCALE_TWEEN_DURATION)
	await scale_tween.finished


func tween_position(goal: Vector2 = position) -> void:
	var pos_tween = create_tween().set_parallel()
	pos_tween.tween_property(self, "position", object_to_interact.center.global_position, SCALE_TWEEN_DURATION)


func enable_arm(state: bool, full_disable: bool = false) -> void:
	arm.hits_enabled = state
	if full_disable:
		arm.rotating = false


func set_velocity_mult(multiplier: float) -> void:
	move_component.velocity_multiplier = multiplier


func set_jump_impulse_mult(multiplier: float) -> void:
	move_component.jump_impulse_multiplier = multiplier


func match_action_for_interactive_object_class() -> void:
	if object_to_interact is LocationPortal:
		freeze = true
		tween_scale(true)
		tween_position(object_to_interact.global_position)


func finish() -> void:
	control_enabled = false


func on_artefact_unequipped(artefact: Artefact) -> void:
	artefact_unequipped.emit(artefact)
	enable_arm(true)


func _ready() -> void:
	freeze = true
	await tween_scale()
	freeze = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and (is_instance_valid(object_to_interact) and can_interact):
		can_interact = false
		interact_timer.start()
		object_to_interact.interact()
		match_action_for_interactive_object_class()
		prints("Now you can't interact!", can_interact)

	if event.is_action_pressed("unequip_artefact") and equipped_artefact:
		pass

	elif event.is_action_pressed("switch_camera_mode") and free_camera_mode_enabled:
		camera.zoom = Vector2.ONE
		camera.free_mode = not camera.free_mode
		move_component.movement_enabled = not move_component.movement_enabled


func _on_interactive_object_player_entered(object: InteractiveObject) -> void:
	object_to_interact = object

func _on_interactive_object_player_exited(object: InteractiveObject) -> void:
	if object_to_interact == object:
		object_to_interact = null


func _on_interact_timer_timeout() -> void:
	if control_enabled:
		can_interact = true
		prints("Now you can again interact!", can_interact)


func _on_level_finished(score: int, time_s: float) -> void:
	finish()


func _on_creature_died() -> void:
	super._on_creature_died()
	move_component.movement_enabled = false
	enable_arm(false)
