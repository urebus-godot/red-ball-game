class_name Emeraldium extends Artefact

const VELOCITY_MULTIPLIER: float = 1.8
const JUMP_FORCE_MULTIPLIER: float = 1

var change_velocity: bool = true
var change_jump_force: bool = true


func activate_artifact() -> void:
	if change_velocity:
		player.set_velocity_mult(VELOCITY_MULTIPLIER)

	if change_jump_force:
		player.set_jump_impulse_mult(JUMP_FORCE_MULTIPLIER)


func deactivate_artifact() -> void:
	player.set_velocity_mult(1)
	player.set_jump_impulse_mult(1)
