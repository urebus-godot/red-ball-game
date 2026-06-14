@abstract class_name InteractiveObject extends Area2D

signal player_entered(object: InteractiveObject)
signal player_exited(object: InteractiveObject)

@export var interaction_delay: float = 0.0
@export var showed_name: String = "interactive object"

@abstract func can_interact() -> bool

func interact() -> void: ## This function is being called when user presses interaction action
	if interaction_delay > 0.0:
		await get_tree().create_timer(interaction_delay).timeout

func _on_body_entered(body: Node2D) -> void:
	if can_interact():
		player_entered.emit(self)
	else:
		return

func _on_body_exited(body: Node2D) -> void:
	if can_interact():
		player_exited.emit(self)
	else:
		return
