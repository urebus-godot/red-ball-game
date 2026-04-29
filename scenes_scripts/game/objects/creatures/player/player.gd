class_name Player extends Creature

@export var control_component: ControlComponent

var object_to_interact: InteractiveObject = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and object_to_interact:
		object_to_interact.interact()


func _on_interactive_object_player_entered(object: InteractiveObject) -> void:
	object_to_interact = object
