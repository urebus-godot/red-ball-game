@abstract class_name InteractiveObject extends Area2D

signal player_entered(object: InteractiveObject)
signal player_exited(object: InteractiveObject)

@abstract func interact() -> void ## This function is being called when user presses interaction action

func _on_body_entered(body: Node2D) -> void:
	player_entered.emit(self)

func _on_body_exited(body: Node2D) -> void:
	player_exited.emit(self)
