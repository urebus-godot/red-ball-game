class_name ControlComponent extends Node

@export var move_component: MoveComponent
@export var player: Player

var is_jump_input: bool = false
var collide_with_platforms: bool = true
var move_direction: float = 0.0


func move_input() -> void:
	move_direction = Input.get_axis("left", "right")
	if move_direction > 0:
		move_component.move_right()
	elif move_direction < 0:
		move_component.move_left()


func jump_input(delta: float) -> void:
	if Input.is_action_pressed("jump") and not (is_jump_input and move_component.is_on_floor()):
		is_jump_input = true
		move_component.jump(delta)

	elif Input.is_action_just_released("jump"):
		move_component.disable_jump()
		is_jump_input = false


func leave_platform_input() -> void:
	if Input.is_action_pressed("down"):
		player.set_collision_mask_value(Constants.PLATFORMS_COLL_MASK_NUMBER, false)

	elif Input.is_action_just_released("down"):
		print(player.linear_velocity.y)
		var time = clampf(80 / player.linear_velocity.y, 0.0, 0.6)
		print("time to set platform coll mask = ", time)
		await get_tree().create_timer(time).timeout
		player.set_collision_mask_value(Constants.PLATFORMS_COLL_MASK_NUMBER, true)


func _physics_process(delta: float) -> void:
	move_input()
	jump_input(delta)
	leave_platform_input()


func _on_move_component_enter_floor() -> void:
	pass
