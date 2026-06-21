extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var objects_to_activate: Array[ActivatedObject]
@export var deactivate_on_body_exit: bool = true

var collisions_count: int = 0


func _on_body_entered(body: Node2D) -> void:
	collisions_count += 1
	if not objects_to_activate:
		printerr("There are no objects to activate!")
	for obj in objects_to_activate:
		print("Activating ", obj.name)
		obj.activate()
	animation_player.play("press")


func _on_body_exited(body: Node2D) -> void:
	collisions_count -= 1
	if not objects_to_activate:
		printerr("There are no objects to deactivate!")
	if collisions_count == 0 and deactivate_on_body_exit:
		for obj in objects_to_activate:
			print("Deactivating ", obj.name)
			obj.deactivate()
		animation_player.play("unpress")
