class_name GameUILayer extends CanvasLayer

@onready var interact_label: Label = $InteractLabel


func _on_interactive_object_player_entered(object: InteractiveObject) -> void:
	print("Interactive object entered: ", object.showed_name)
	interact_label.show_label(object.showed_name)

func _on_interactive_object_player_exited(object: InteractiveObject) -> void:
	print("Interactive object exited: ", object.showed_name)
	interact_label.hide_label()
