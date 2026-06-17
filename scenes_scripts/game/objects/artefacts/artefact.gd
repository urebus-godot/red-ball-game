class_name Artefact extends Node2D

@export var action_name: String = "use_artifact"

@export_enum(
	Constants.SAPPHIRIUM, 
	Constants.EMERALDIUM, 
	Constants.RUBIUM,
	Constants.DIAMONDIUM
	) var artefact_name: String

var player: Player = null
var artefacts_parent: Node = null
var ui_layer: GameUILayer = null


func use_artifact() -> void:
	pass


func activate_artifact() -> void:
	pass

func deactivate_artifact() -> void:
	pass


func unequip_artefact() -> void:
	General.spawn_pickable_artefact(player, artefacts_parent, ui_layer)
	player.on_artefact_unequipped(self)
	queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action_name):
		activate_artifact()

	elif event.is_action_released(action_name):
		deactivate_artifact()

	elif event.is_action_pressed("unequip_artefact"):
		unequip_artefact()
