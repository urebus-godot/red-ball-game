extends Node2D

@onready var background_layer: CanvasLayer = $BackgroundLayer
@onready var interact_label: Label = $UILayer/InteractLabel
@onready var portals: Node2D = $Portals
@onready var player: Player = $Player


func _ready() -> void:
	background_layer.visible = true
	for portal in portals.get_children():
		if portal is InteractiveObject:
			portal.player_entered.connect(player._on_interactive_object_player_entered)
			portal.player_exited.connect(player._on_interactive_object_player_exited)

			portal.player_entered.connect(interact_label._on_interactive_object_player_entered)
			portal.player_exited.connect(interact_label._on_interactive_object_player_exited)
