extends Camera2D

const TRANS_TYPE: Tween.TransitionType = Tween.TransitionType.TRANS_SINE
const TWEEN_DURATION: float = 0.6
const FREE_MODE_VELOCITY: float = 14

@export var player: Player
@export var trans_enabled: bool = false

var direction: Constants.Direction = Constants.Direction.CENTER
var player_move_direction: Constants.Direction = Constants.Direction.CENTER

var follow_player: bool = true
var free_mode: bool = false


func trans_offset(trans_direction: Constants.Direction) -> void:
	var tween = create_tween().set_trans(TRANS_TYPE)
	if trans_direction == Constants.Direction.RIGHT:
		tween.tween_property(self, "offset:x", 200.0, TWEEN_DURATION)
	elif trans_direction == Constants.Direction.LEFT:
		tween.tween_property(self, "offset:x", -200.0, TWEEN_DURATION)
	else:
		tween.tween_property(self, "offset:x", 0.0, TWEEN_DURATION)


func check_for_trans() -> void:
	while true:
		await get_tree().create_timer(.01).timeout
		if player_move_direction == 0:
			trans_offset(Constants.Direction.CENTER)
		if player_move_direction != sign(player.control_component.move_direction):
			await get_tree().create_timer(0.3).timeout
			player_move_direction = sign(player.linear_velocity.x)
			trans_offset(player_move_direction)
			#print("player_move_direction=", player_move_direction)


func _process(delta: float) -> void:
	if not free_mode and follow_player:
		position = player.position
	elif free_mode:
		var move_direction = Input.get_vector(
			"left", "right", "up", "down"
			).normalized()
		var speed_up = Input.is_action_pressed("speed_up")
		position += (move_direction * FREE_MODE_VELOCITY * 3
		) if speed_up else (
			move_direction * FREE_MODE_VELOCITY
			)


func _ready() -> void:
	if trans_enabled:
		check_for_trans()


func _on_player_died() -> void:
	follow_player = false
