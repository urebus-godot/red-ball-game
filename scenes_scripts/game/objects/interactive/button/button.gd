extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var object_to_activate: ActivatedObject


func _on_body_entered(body: Node2D) -> void:
	object_to_activate.activate()
	animation_player.play("press")


func _on_body_exited(body: Node2D) -> void:
	object_to_activate.deactivate()
	animation_player.play("unpress")
