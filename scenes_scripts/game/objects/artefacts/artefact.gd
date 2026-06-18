class_name Artefact extends Node2D

@export var action_name: String = "use_artefact"

@export_enum(
	Constants.SAPPHIRIUM, 
	Constants.EMERALDIUM, 
	Constants.RUBIUM,
	Constants.DIAMONDIUM
	) var artefact_name: String

var activated: bool = false

var player: Player = null
var artefacts_parent: Node = null
var ui_layer: GameUILayer = null


func use_artefact() -> void:
	pass


func activate_artefact() -> void:
	activated = true
	prints("Activated artefact!", activated)

func deactivate_artefact() -> void:
	activated = false
	prints("Deactivated artefact!", not activated)


func unequip_artefact() -> void:
	General.spawn_pickable_artefact(player, artefacts_parent, ui_layer)
	player.on_artefact_unequipped(self)
	queue_free()


func _input(event: InputEvent) -> void:
	if not player.control_enabled: return

	if event.is_action_pressed(action_name):
		activate_artefact()

	elif event.is_action_released(action_name):
		deactivate_artefact()

	elif event.is_action_pressed("unequip_artefact"):
		unequip_artefact()
