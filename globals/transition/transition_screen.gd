extends CanvasLayer


func start_trans() -> void:
	pass

func end_trans() -> void:
	pass


func change_scene(path: String) -> void:
	#await start_trans()
	get_tree().change_scene_to_file(path)
