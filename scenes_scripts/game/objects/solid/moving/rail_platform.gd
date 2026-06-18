extends Node2D

@onready var rail_wheel: Node2D = $RailWheel
@onready var rail_wheel_2: Node2D = $RailWheel2

@export var pos_x_offset: float

var start_pos_x: float
var prev_pos_x: float
var time_to_go_to_bound: float = 0.0
var Direction = Constants.Direction
## 150,8 - lemgth of wheel

func move(direction: Constants.Direction) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)

	match direction:
		Direction.RIGHT:
			print("Started moving RIGHT!")
			tween.tween_property(self, "position:x", start_pos_x + pos_x_offset, time_to_go_to_bound)

		Direction.LEFT:
			print("Started moving LEFT!")
			tween.tween_property(self, "position:x", start_pos_x, time_to_go_to_bound)

	await tween.finished

	var new_direction = Direction.LEFT if direction == Direction.RIGHT else Direction.RIGHT
	move(new_direction)


func _ready() -> void:
	start_pos_x = position.x
	time_to_go_to_bound = pos_x_offset / 250
	print(time_to_go_to_bound)
	move(Direction.RIGHT)


func _process(delta: float) -> void:
	var platform_velocity = position.x - prev_pos_x
	rail_wheel.rotation += platform_velocity * 0.03016#15.08
	rail_wheel_2.rotation = rail_wheel.rotation
	prev_pos_x = position.x
