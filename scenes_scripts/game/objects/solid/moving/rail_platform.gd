extends ActivatedObject

@export var wheels: Array[Sprite2D]
@export var pos_offset: Vector2
#@export var start_offset: float = 0.0

var start_pos: Vector2
var prev_pos: Vector2
var time_to_go_to_bound: float = 0.0
var Direction = Constants.Direction
## 147,56 - lemgth of wheel

func move(direction: Constants.Direction, offset: float = 0.0) -> void:
	print("Enter move func")
	if is_activated:
		print("Start tween")
		var tween = create_tween().set_trans(Tween.TRANS_SINE)

		match direction:
			Direction.RIGHT:
				tween.tween_property(
					self, "position", start_pos + pos_offset, time_to_go_to_bound
					)

			Direction.LEFT:
				tween.tween_property(
					self, "position", start_pos, time_to_go_to_bound
					)

		await tween.finished

		if direction == Direction.RIGHT:
			move(Direction.LEFT)
		else:
			move(Direction.RIGHT)


func activate() -> void:
	await super()
	move(Direction.RIGHT)


func _ready() -> void:
	start_pos = position
	prev_pos = start_pos
	time_to_go_to_bound = pos_offset.length() / 220

	if is_activated:
		move(Direction.RIGHT)#, start_offset)


func _process(delta: float) -> void:
	var platform_velocity = (position - prev_pos).length()
	for w in wheels:
		w.rotation += platform_velocity * 0.03016#15.08
	prev_pos = position
