extends Creature

var object_to_interact: Node = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and object_to_interact:
		object_to_interact
