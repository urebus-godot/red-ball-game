extends Panel

@onready var container: VBoxContainer = $VBoxContainer

@export var nodes_for_texts: Array[Node]
@export var properties_for_texts: Array[String]
@export var enabled: bool = true

@onready var labels: Array = container.get_children()


func set_texts() -> void:
	for i in range(len(labels)):
		if not (len(nodes_for_texts) == len(properties_for_texts)):
			printerr("Label or property or node isn't valid!")
			return
		var label: Label = labels[i]
		var property = properties_for_texts[i]
		var node: Node = nodes_for_texts[i]
		var text = "%s: %s" % [property, node.get(property)]
		label.set_text(text)
		if i + 1 >= len(nodes_for_texts):
			return


func _process(delta: float) -> void:
	set_texts()


func _ready() -> void:
	if not enabled:
		queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_debug"):
		visible = not visible
