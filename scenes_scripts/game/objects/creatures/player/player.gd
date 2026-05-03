class_name Player extends Creature

@onready var interact_timer: Timer = $InteractTimer

@export var control_component: ControlComponent

var can_interact: bool = true

var object_to_interact: InteractiveObject = null


func tween_scale(decrement: bool = false) -> void:
	var scale_tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	if decrement:
		scale_tween.tween_property(self, "scale", Vector2.ZERO, 0.3)
	else:
		scale = Vector2.ZERO
		scale_tween.tween_property(self, "scale", Vector2.ONE, 0.3)
	await scale_tween.finished


func tween_position(goal: Vector2 = position) -> void:
	var pos_tween = create_tween().set_parallel()
	pos_tween.tween_property(self, "position", object_to_interact.center.global_position, 0.16)


func match_action_for_interactive_object_class() -> void:
	if object_to_interact is LocationPortal:
		freeze = true
		tween_scale(true)
		tween_position(object_to_interact.global_position)


func _ready() -> void:
	freeze = true
	await tween_scale()
	freeze = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and (is_instance_valid(object_to_interact) and can_interact):
		can_interact = false
		interact_timer.start()
		object_to_interact.interact()
		match_action_for_interactive_object_class()
		prints("Now you can't interact!", can_interact)


func _on_interactive_object_player_entered(object: InteractiveObject) -> void:
	object_to_interact = object

func _on_interactive_object_player_exited(object: InteractiveObject) -> void:
	if object_to_interact == object:
		object_to_interact = null


func _on_interact_timer_timeout() -> void:
	can_interact = true
	prints("Now you can again interact!", can_interact)
