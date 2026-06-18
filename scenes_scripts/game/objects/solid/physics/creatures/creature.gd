class_name Creature extends PhysicsObject

signal creature_died

@export var life_component: LifeComponent


func is_alive() -> bool:
	return life_component.alive


func get_hit(impulse: Vector2 = Vector2.UP * 300) -> void:
	life_component.get_hit(impulse)


func set_properties_on_death_jump() -> void:
	collision_mask = 0
	collision_layer = 0
	z_index = 10


func _on_creature_died() -> void:
	creature_died.emit()
