class_name ControlComponent extends Node

@export var move_component: MoveComponent

var is_jump_input: bool = false


func move_input() -> void:
	var direction = Input.get_axis("left", "right")
	if direction > 0:
		move_component.move_right()
	elif direction < 0:
		move_component.move_left()

func jump_input(delta: float) -> void:
	if Input.is_action_pressed("jump") and not (is_jump_input and move_component.is_on_floor()):
		is_jump_input = true
		move_component.jump(delta)
	elif Input.is_action_just_released("jump"):
		move_component.disable_jump()
		is_jump_input = false


func _physics_process(delta: float) -> void:
	move_input()
	jump_input(delta)


func _on_move_component_enter_floor() -> void:
	pass
