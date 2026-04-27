extends Camera2D

@export var player: Creature


func _process(delta: float) -> void:
	position = player.position
