extends Node2D

signal player_entered(object: InteractiveObject)
signal player_exited(object: InteractiveObject)

@export var artefacts_parent: Node = get_parent()
@export var ui_layer: GameUILayer = null

@export var change_velocity: bool = true
@export var change_jump_force: bool = true
