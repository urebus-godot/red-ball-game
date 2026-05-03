class_name LocationPortal extends InteractiveObject

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var center: Marker2D = $Center
@onready var game_data: GameData = DataManager.game_data

@export var level: int = 1
@export_enum(
	Constants.NO_PATH,
	Constants.MAIN_MENU_PATH,
	Constants.WORLD_PATH,
) var scene_path: String = Constants.NO_PATH


func can_interact() -> bool:
	var available_levels = game_data.levels_completed + 1
	return available_levels >= level


func interact() -> void:
	await super.interact()
	if can_interact():
		if scene_path == Constants.NO_PATH:
			TransitionScreen.change_scene(Constants.LEVEL_PATH % level)
		else:
			TransitionScreen.change_scene(scene_path)


func _ready() -> void:
	if scene_path == Constants.NO_PATH:
		showed_name = "portal to the level %s" % level
	showed_name = "the " + showed_name


func _on_body_entered(body: Node2D) -> void:
	super._on_body_entered(body)
	animated_sprite.play("open")

func _on_body_exited(body: Node2D) -> void:
	super._on_body_exited(body)
	animated_sprite.play("close")
