class_name ControlComponent extends Node

@export var move_component: MoveComponent


func move_input() -> void:
	var direction = Input.get_axis("left", "right")
	if direction > 0:
		move_component.move_right()
	elif direction < 0:
		move_component.move_left()

func jump_input() -> void:
	if Input.is_action_pressed("jump"):
		move_component.jump()


func _physics_process(delta: float) -> void:
	move_input()
	jump_input()
