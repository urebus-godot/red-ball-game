class_name LifeComponent extends Node

signal creature_died

const DIE_IMPULSE: float = 600
const INVINCIBILITY_TIME_S: float = 0.4

var alive: bool = true
var invincible: bool = false

@export var creature: Creature
@export var animation_player: AnimationPlayer
@export var invincibility_timer: Timer

@export var lives: int = 1


func get_hit(impulse: Vector2)-> void:
	if not invincible:
		print("Got hit!")
		lives -= 1
		if lives == 0:
			die()
		else:
			creature.apply_central_impulse(impulse)

			if invincibility_timer:
				invincible = true
				invincibility_timer.start(INVINCIBILITY_TIME_S)

				if animation_player:
					animation_player.play("invincibility")


func die(death_jump: bool = true) -> void:
	if alive:
		creature_died.emit()
		alive = false

		if death_jump:
			creature.collision_mask = 0
			creature.collision_layer = 0
			creature.z_index = 10

			creature.apply_central_impulse(Vector2(0, -DIE_IMPULSE))
			
			var tween = creature.create_tween().set_trans(Tween.TRANS_QUAD)
			tween.tween_property(
				creature, "scale", creature.scale * 2.25, 4.5
				)


func _on_invincibility_timer_timeout() -> void:
	invincible = false
