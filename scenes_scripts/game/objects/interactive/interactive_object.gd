@abstract class_name InteractiveObject extends Area2D

signal player_entered(object: InteractiveObject)
signal player_exited(object: InteractiveObject)

@export var interaction_delay: float = 0.0
@export var showed_name: String = "interactive object"

var player: Player = null


func can_interact() -> bool:
	return true


func interact() -> void: ## This function is being called when user presses interaction action
	if interaction_delay > 0.0:
		await get_tree().create_timer(interaction_delay).timeout


func _on_body_entered(body: Player) -> void:
	if can_interact():
		player_entered.emit(self)
		player = body
	else:
		return

func _on_body_exited(body: Player) -> void:
	if can_interact():
		player_exited.emit(self)
		player = null
	else:
		return
