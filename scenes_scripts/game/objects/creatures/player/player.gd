class_name Player extends Creature

@onready var interact_timer: Timer = $InteractTimer

@export var control_component: ControlComponent

var can_interact: bool = true

var object_to_interact: InteractiveObject = null


func match_action_for_interactive_object_class() -> void:
	if object_to_interact is LocationPortal:
		freeze = true
		var scale_tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
		scale_tween.tween_property(self, "scale", Vector2.ZERO, 0.3)
		var pos_tween = create_tween().set_parallel()
		scale_tween.tween_property(self, "position", object_to_interact.center.global_position, 0.16)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_instance_valid(object_to_interact):
		interact_timer.start()
		can_interact = false
		object_to_interact.interact()
		match_action_for_interactive_object_class()


func _on_interactive_object_player_entered(object: InteractiveObject) -> void:
	object_to_interact = object

func _on_interactive_object_player_exited(object: InteractiveObject) -> void:
	if object_to_interact == object:
		object_to_interact = null


func _on_interact_timer_timeout() -> void:
	can_interact = true
