class_name LifeComponent extends Node

signal creature_died

var alive: bool = true

@export var creature: Creature

func die(death_jump: bool = true) -> void:
	if alive:
		creature_died.emit()
		alive = false
		
		if death_jump:
			creature.collision_mask = 0
			creature.collision_layer = 0
			creature.z_index = 10
			
			creature.apply_central_impulse(Vector2(0, -800))
			
			var tween = creature.create_tween().set_trans(Tween.TRANS_QUAD)
			tween.tween_property(
				creature, "scale", creature.scale * 2.25, 4.5
				)
