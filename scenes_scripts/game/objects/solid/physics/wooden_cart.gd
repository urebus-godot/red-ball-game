extends PhysicsObject

const PUSH_FORCE: float = 1000

var push_direction: Constants.Direction = Constants.Direction.CENTER


func _physics_process(delta: float) -> void:
	if push_direction == Constants.Direction.RIGHT and Input.is_action_pressed("right"):
		apply_central_force(Vector2.RIGHT * PUSH_FORCE)
	elif push_direction == Constants.Direction.LEFT and Input.is_action_pressed("left"):
		apply_central_force(Vector2.LEFT * PUSH_FORCE)


func _on_left_push_area_body_entered(body: Node2D) -> void:
	push_direction = Constants.Direction.LEFT

func _on_left_push_area_body_exited(body: Node2D) -> void:
	push_direction = Constants.Direction.CENTER


func _on_right_push_area_body_entered(body: Node2D) -> void:
	push_direction = Constants.Direction.RIGHT

func _on_right_push_area_body_exited(body: Node2D) -> void:
	push_direction = Constants.Direction.CENTER
