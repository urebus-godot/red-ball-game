extends Node

const NO_PATH: String = "none"
const MAIN_MENU_PATH: String = "res://scenes_scripts/ui/root/main_menu.tscn"
const WORLD_PATH: String = "res://scenes_scripts/game/root/world.tscn"
const LEVEL_PATH: String = "res://scenes_scripts/game/levels/level_%s.tscn"
const ARTEFACT_PATH: String = "res://scenes_scripts/game/objects/artefacts/%s.tscn"
const PICKABLE_ARTEFACT_PATH: String = "res://scenes_scripts/game/objects/interactive/pickable/artefacts/%s.tscn"

const TWEEN_DURATION: float = 0.3
const TRANS_TYPE: Tween.TransitionType = Tween.TRANS_QUAD
const UI_TRANS_TYPE: Tween.TransitionType = Tween.TRANS_SINE

const MOBILITY: String = "MOBILITY"
const MANIPULATOR: String = "MANIPULATOR"
const BUFFER: String = "BUFFER"
