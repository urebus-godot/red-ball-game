class_name Creature extends PhysicsObject

signal creature_died

@export var life_component: LifeComponent


func _on_creature_died() -> void:
	creature_died.emit()
