class_name PickableArtefactRoot extends Node2D

signal player_entered(object: InteractiveObject)
signal player_exited(object: InteractiveObject)

@export var artefacts_parent: Node = get_parent()
@export var ui_layer: GameUILayer = null
@export var arguments: Dictionary[String, Variant]
