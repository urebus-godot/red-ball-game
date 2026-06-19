extends Node

## ---- Paths -----
const NO_PATH: String = "none"

## ----- Main scenes path ------
const MAIN_MENU_PATH: String = "res://scenes_scripts/ui/root/main_menu.tscn"
const WORLD_PATH: String = "res://scenes_scripts/game/root/world.tscn"
const VALLEY_LEVEL_PATH: String = "res://scenes_scripts/game/levels/valley/level_%s.tscn"

## ----- Object scenes path ------
const ARTEFACT_PATH: String = "res://scenes_scripts/game/objects/artefacts/%s/%s.tscn"
const PICKABLE_ARTEFACT_PATH: String = "res://scenes_scripts/game/objects/interactive/pickable/artefacts/%s/pickable_%s.tscn"


## ----- UI tween config ------
const TWEEN_DURATION: float = 0.3
const TRANS_TYPE: Tween.TransitionType = Tween.TRANS_QUAD
const UI_TRANS_TYPE: Tween.TransitionType = Tween.TRANS_SINE


## ----- Artefact names ------
const SAPPHIRIUM: String = "sapphirium"
const EMERALDIUM: String = "emeraldium"
const RUBIUM: String = "rubium"
const DIAMONDIUM: String = "diamondium"


## ----- Game constants ------
const SPIRAL_ROTATION_SPEED: float = 0.8
const PLATFORMS_COLL_MASK_NUMBER: int = 6


enum Direction {
	LEFT = -1, CENTER = 0, RIGHT = 1
}
