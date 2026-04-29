extends InteractiveObject

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_data: GameData = DataManager.game_data

@export var level: int


func interact() -> void:
	var available_levels = game_data.levels_completed + 1
	if available_levels >= level:
		TransitionScreen.change_scene(Constants.LEVEL_PATH % level)


func _on_body_entered(body: Node2D) -> void:
	super._on_body_entered(body)
	animated_sprite.play("open")

func _on_body_exited(body: Node2D) -> void:
	super._on_body_entered(body)
	animated_sprite.play("close")
