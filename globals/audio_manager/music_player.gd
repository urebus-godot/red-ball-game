extends AudioStreamPlayer

enum Soundtrack {
	MAIN_MENU,
	GAME
}

const SOUNDTRACK_PATH_DICT: Dictionary[Soundtrack, String] = {
	Soundtrack.MAIN_MENU: "res://resources/audio/music/main_menu.mp3",
	Soundtrack.GAME: "res://resources/audio/music/game.mp3"
}


func play_soundtrack(soundtrack_name: Soundtrack, volume_trans: bool = false):
	stream = load(SOUNDTRACK_PATH_DICT[soundtrack_name])
	play()

	if volume_trans:
		volume_linear = 0
		var tween = create_tween().tween_property(
			self, "volume_linear", 1.0, 0.6
		)
