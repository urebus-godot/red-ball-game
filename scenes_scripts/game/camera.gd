extends Camera2D

enum Direction {
	LEFT = -1, CENTER = 0, RIGHT = 1
}
const TRANS_TYPE: Tween.TransitionType = Tween.TransitionType.TRANS_SINE
const TWEEN_DURATION: float = 0.6

@export var player: Player
@export var trans_enabled: bool = true

var direction: Direction = Direction.CENTER
var player_move_direction: Direction = Direction.CENTER


func trans_offset(trans_direction: Direction) -> void:
	var tween = create_tween().set_trans(TRANS_TYPE)
	if trans_direction == Direction.RIGHT:
		tween.tween_property(self, "offset:x", 200.0, TWEEN_DURATION)
	elif trans_direction == Direction.LEFT:
		tween.tween_property(self, "offset:x", -200.0, TWEEN_DURATION)
	else:
		tween.tween_property(self, "offset:x", 0.0, TWEEN_DURATION)


func check_for_trans() -> void:
	while true:
		await get_tree().create_timer(.01).timeout
		if player_move_direction == 0:
			trans_offset(Direction.CENTER)
		if player_move_direction != sign(player.control_component.move_direction):
			await get_tree().create_timer(0.3).timeout
			player_move_direction = sign(player.linear_velocity.x)
			trans_offset(player_move_direction)
			print("player_move_direction=", player_move_direction)


func _process(delta: float) -> void:
	position = player.position


func _ready() -> void:
	if trans_enabled:
		check_for_trans()
