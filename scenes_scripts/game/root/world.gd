extends Node2D

@onready var doors: Node2D = $Doors
@onready var player: Player = $Player


func _ready() -> void:
	for door in doors.get_children():
		if door is InteractiveObject:
			door.player_entered.connect(player._on_interactive_object_player_entered)
			door.player_exited.connect(player._on_interactive_object_player_exited)
