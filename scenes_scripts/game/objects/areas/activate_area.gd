extends Area2D

@export var objects_to_activate: Array[ActivatedObject]


func _on_body_entered(body: Node2D) -> void:
	for obj in objects_to_activate:
		obj.activate()
	queue_free()

#func _on_body_exited(body: Node2D) -> void:
#	object_to_activate.activate()
#	queue_free()
