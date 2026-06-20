class_name Artefact extends Node2D

@export var action_name: String = "use_artefact"

@export_enum(
	Constants.SAPPHIRIUM, 
	Constants.EMERALDIUM, 
	Constants.RUBIUM,
	Constants.DIAMONDIUM
	) var artefact_name: String

var activated: bool = false
var charged: bool = true:
	set(value):
		charged = value
		if not charged:
			deactivate_artefact()

var player: Player = null
var artefacts_parent: Node = null
var ui_layer: GameUILayer = null


func activate_artefact() -> void:
	if charged:
		activated = true


func deactivate_artefact() -> void:
	activated = false


func unequip_artefact() -> void:
	if charged:
		General.spawn_pickable_artefact(player, artefacts_parent, ui_layer)
	player.on_artefact_unequipped(self)
	queue_free()


func _input(event: InputEvent) -> void:
	if not player.control_enabled: return

	if event.is_action_pressed("unequip_artefact"):
		unequip_artefact()

	elif event.is_action_pressed(action_name):
		print("Input activating artefact")
		activate_artefact()

	elif event.is_action_released(action_name):
		print("Input deactivating artefact")
		deactivate_artefact()
