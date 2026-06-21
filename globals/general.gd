extends Node

func format_time(seconds: float) -> String:
	var minutes = floori(seconds / 60)
	print("minutes = ",minutes)
	seconds = int(seconds) % 60
	print("seconds = ",seconds)
	return "%02d:%02d" % [minutes, snappedf(seconds, 0.01)]


func select_level_path(level: int) -> String:
	var base_path = ""
	if level < 10:
		base_path = Constants.VALLEY_LEVEL_PATH
	return base_path % level


func spawn_pickable_artefact(
	player: Player, 
	artefacts_parent: Node2D,
	ui_layer: GameUILayer = null, 
	args_dict: Dictionary = {}
	) -> Node2D:
	var artefact_name = player.equipped_artefact.artefact_name
	var pickable_artefact_scene = load(
		Constants.PICKABLE_ARTEFACT_PATH % [artefact_name, artefact_name])
	var pickable_artefact = pickable_artefact_scene.instantiate()

	pickable_artefact.position = player.global_position
	pickable_artefact.artefacts_parent = artefacts_parent
	pickable_artefact.charged = player.equipped_artefact.charged

	pickable_artefact.player_entered.connect(player._on_interactive_object_player_entered)
	pickable_artefact.player_exited.connect(player._on_interactive_object_player_exited)

	if ui_layer:
		pickable_artefact.ui_layer = ui_layer

		pickable_artefact.player_entered.connect(ui_layer._on_interactive_object_player_entered)
		pickable_artefact.player_exited.connect(ui_layer._on_interactive_object_player_exited)
		print("Connected signals to UI Layer!")

	#match pickable_artefact.artefact_name:
	#	Constants.EMERALDIUM:
	for arg_name in args_dict:
		pickable_artefact.set(arg_name, args_dict[arg_name])

	artefacts_parent.add_child(pickable_artefact)

	return pickable_artefact
