class_name PatrolComponent extends Node

@export var move_component: RoundMoveComponent
@export var creature: Creature

@export var left_x_bound: float
@export var right_x_bound: float
@export var jump_time: float = 2.2
@export var jumping: bool = false

@export var direction: Constants.Direction = Constants.Direction.RIGHT


func move() -> void:
	if direction == Constants.Direction.RIGHT:
		move_component.move_right()
	else:
		move_component.move_left()


func jump() -> void:
	if jumping:
		var time_to_jump = randf_range(jump_time - 0.3, jump_time + 0.3)

		await get_tree().create_timer(time_to_jump).timeout

		move_component.jump()
		if creature.is_alive():
			jump()


func pick_direction() -> void:
	if creature.position.x > right_x_bound:
		direction = Constants.Direction.LEFT
	elif creature.position.x < left_x_bound:
		direction = Constants.Direction.RIGHT


func _ready() -> void:
	left_x_bound = creature.position.x - 360
	right_x_bound = creature.position.x + 360
	jump()


func _physics_process(delta: float) -> void:
	if creature.is_alive():
		
		move()
		pick_direction()
