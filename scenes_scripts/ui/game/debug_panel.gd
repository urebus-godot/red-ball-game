extends Panel

@onready var container: VBoxContainer = $VBoxContainer

@export var player: Player = null
@export var texts_titles: Array[String]
@export var enabled: bool = true

@onready var labels: Array = container.get_children()


func set_texts() -> void:
	if not texts_titles or not player: return
	if texts_titles[0] and labels[0]:
		labels[0].text = texts_titles[0] + ": " + str(player.move_component.is_in_air())


func _process(delta: float) -> void:
	set_texts()


func _ready() -> void:
	if not enabled:
		queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_debug"):
		visible = not visible
