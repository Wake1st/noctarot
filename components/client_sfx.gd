class_name ClientSfx
extends AudioStreamPlayer


const HAPPY_MOTH = preload("res://assets/audio/Happy Moth.wav")
const SAD_MOTH = preload("res://assets/audio/Sad Moth.wav")
const GAME_OVER = preload("res://assets/audio/Sad Moth (Game Over).wav")

func happy() -> void:
	stream = HAPPY_MOTH
	play()


func sad() -> void:
	stream = SAD_MOTH
	play()


func over() -> void:
	stream = GAME_OVER
	play()
