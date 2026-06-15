extends Node

func format_time(seconds: float) -> String:
	var minutes = floori(seconds / 60)
	seconds = int(seconds) % 2
	return "%02d:%02d" % [minutes, snappedf(seconds, 0.01)]
