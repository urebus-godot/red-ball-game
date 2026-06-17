class_name LocationPortal extends InteractiveObject

@onready var spiral_sprite: Sprite2D = $SpiralSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var center: Marker2D = $Center
@onready var game_data: GameData = DataManager.game_data

@export var level: int = 0
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
		if level > 0:
			TransitionScreen.change_scene(General.select_level_path(level))
		else:
			TransitionScreen.change_scene(scene_path)


func _ready() -> void:
	if level > 0:
		showed_name = "Portal to Level %s" % level
	showed_name = "The " + showed_name


func _process(delta: float) -> void:
	spiral_sprite.rotation_degrees += Constants.SPIRAL_ROTATION_SPEED


func _on_body_entered(body: Node2D) -> void:
	if can_interact():
		super._on_body_entered(body)
		animation_player.play("show_spiral")
		animated_sprite.play("open")

func _on_body_exited(body: Node2D) -> void:
	if can_interact():
		super._on_body_exited(body)
		animation_player.play("hide_spiral")
		animated_sprite.play("close")
