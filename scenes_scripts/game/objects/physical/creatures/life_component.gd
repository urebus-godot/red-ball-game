class_name LifeComponent extends Node

signal creature_died

var alive: bool = true

@export var creature: Creature
@export var move_component: MoveComponent

func die() -> void:
	if alive:
		alive = false
		move_component.movement_enabled = false
		creature.collision_mask = 0
		creature.collision_layer = 0
		creature.z_index = 10
		
		creature.apply_central_impulse(Vector2(0, -800))
		creature_died.emit()
		
		var tween = creature.create_tween().set_trans(Tween.TRANS_QUAD)
		tween.tween_property(
			creature, "scale", creature.scale * 2.25, 4.5
			)
