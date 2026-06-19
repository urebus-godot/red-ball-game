extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var object_to_activate: ActivatedObject


func _on_body_entered(body: Node2D) -> void:
	if not object_to_activate:
		printerr("There is not object to activate!")
	object_to_activate.activate()
	animation_player.play("press")


func _on_body_exited(body: Node2D) -> void:
	if not object_to_activate:
		printerr("There is not object to deactivate!")
	object_to_activate.deactivate()
	animation_player.play("unpress")
