class_name PatrolComponent extends Node

@export var move_component: MoveComponent
@export var target: Creature

@export var left_x_bound: float
@export var right_x_bound: float

var direction: Constants.Direction = Constants.Direction.RIGHT


func move() -> void:
	if direction == Constants.Direction.RIGHT:
		move_component.move_right()
	else:
		move_component.move_left()


func pick_direction() -> void:
	if target.position.x > right_x_bound:
		direction = Constants.Direction.LEFT
	elif target.position.x < left_x_bound:
		direction = Constants.Direction.RIGHT


func _ready() -> void:
	left_x_bound = target.position.x - 320
	right_x_bound = target.position.x + 320


func _physics_process(delta: float) -> void:
	move()
	pick_direction()
