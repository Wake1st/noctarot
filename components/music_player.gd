class_name MusicPlayer
extends AudioStreamPlayer


const BACK_THEN = preload("res://assets/audio/back then.mp3")
const STIRRING = preload("res://assets/audio/stirring.mp3")
const COZY = preload("res://assets/audio/cozy.mp3")

var index: int
var songs: Array[AudioStreamMP3] = [
	BACK_THEN,
	STIRRING,
	COZY
]


func _on_finished():
	index += (index + 1) % songs.size()
	stream = songs[index]
	play()
