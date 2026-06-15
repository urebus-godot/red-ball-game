extends Area2D

@export var object_to_activate: ActivatedObject


func _on_body_entered(body: Node2D) -> void:
	object_to_activate.activate()
	queue_free()

#func _on_body_exited(body: Node2D) -> void:
#	object_to_activate.activate()
#	queue_free()
