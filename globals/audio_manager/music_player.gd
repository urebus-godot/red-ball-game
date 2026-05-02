extends AudioStreamPlayer

var music_path_dict: Dictionary[String, String] = {
	"main menu": "res://resources/audio/music/main_menu.mp3"
}


func play_music(music_name: String):
	stream = load(music_path_dict[music_name])
	play()
