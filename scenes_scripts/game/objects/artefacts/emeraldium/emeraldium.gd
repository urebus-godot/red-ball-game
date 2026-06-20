class_name Emeraldium extends Artefact

const VELOCITY_MULTIPLIER: float = 1.8
const JUMP_IMPULSE_MULTIPLIER: float = 2

var change_velocity: bool = true
var change_jump_impulse: bool = true


func activate_artefact() -> void:
	if not charged: return

	if change_velocity:
		player.set_velocity_mult(VELOCITY_MULTIPLIER)

	if change_jump_impulse:
		player.set_jump_impulse_mult(JUMP_IMPULSE_MULTIPLIER)


func deactivate_artefact() -> void:
	player.set_velocity_mult(1)
	player.set_jump_impulse_mult(1)
