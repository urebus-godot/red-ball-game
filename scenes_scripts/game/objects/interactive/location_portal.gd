class_name LocationPortal extends InteractiveObject

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var center: Marker2D = $Center
@onready var game_data: GameData = DataManager.game_data

@export var level: int = 1
@export_enum(
	"none",
	Constants.MAIN_MENU_PATH,
	Constants.WORLD_PATH,
) var scene_path: String = "none"


func interact() -> void:
	await super.interact()
	var available_levels = game_data.levels_completed + 1
	if available_levels >= level:
		if scene_path == "none":
			TransitionScreen.change_scene(Constants.LEVEL_PATH % level)
		else:
			TransitionScreen.change_scene(scene_path)


func _on_body_entered(body: Node2D) -> void:
	animated_sprite.play("open")
	super._on_body_entered(body)

func _on_body_exited(body: Node2D) -> void:
	super._on_body_exited(body)
	animated_sprite.play("close")
