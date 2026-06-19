class_name GameUILayer extends CanvasLayer

const UI_TWEEN_DUR: float = 0.3

@onready var root: Control = $Root
@onready var interact_label: Label = $Root/InteractLabel

var transition_of_ui: bool = false
var ui_hidden_by_action: bool = false


func hide_ui() -> void:
	print("Hide ui!")
	if not transition_of_ui:
		transition_of_ui = true
		var a_tween = root.create_tween()
		a_tween.tween_property(root, "modulate:a", 0.0, 0.1)

		await a_tween.finished

		visible = false
		transition_of_ui = false


func show_ui() -> void:
	print("Show ui!")
	if not transition_of_ui:
		visible = true
		transition_of_ui = true
		var a_tween = root.create_tween()
		a_tween.tween_property(root, "modulate:a", 1.0, UI_TWEEN_DUR)

		await a_tween.finished

		transition_of_ui = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hide_ui"):
		if root.visible:
			show_ui()
			ui_hidden_by_action = false
		else:
			hide_ui()
			ui_hidden_by_action = true


func _on_interactive_object_player_entered(object: InteractiveObject) -> void:
	interact_label.show_label(object.showed_name)

func _on_interactive_object_player_exited(object: InteractiveObject) -> void:
	interact_label.hide_label()
