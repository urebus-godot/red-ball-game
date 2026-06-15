class_name PickableArtefact extends InteractiveObject

@export var pickable_component: PickableComponent
@export_enum(
	Constants.MOBILITY, 
	Constants.BUFFER, 
	Constants.MANIPULATOR
	) var artefact_name: String

var collected: bool = false


func interact() -> void:
	if not collected:
		collected = true
		player.equip_artefact(artefact_name)
		pickable_component.fade_out()
