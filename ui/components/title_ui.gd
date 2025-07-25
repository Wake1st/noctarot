class_name TitleUI
extends Control


signal finished()

const CHAPER_1 = preload("res://assets/titles/chaper_1.png")
const CHAPER_2 = preload("res://assets/titles/chaper_2.png")
const CHAPER_3 = preload("res://assets/titles/chaper_3.png")
const CHAPER_4 = preload("res://assets/titles/chaper_4.png")
const CHAPER_5 = preload("res://assets/titles/chaper_5.png")

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var isOpening: bool


func display() -> void:
	animation.play("bounce_up")
	isOpening = true


func _on_animation_player_animation_finished(_anim_name):
	timer.start()

func _on_timer_timeout():
	if isOpening:
		isOpening = false
		animation.play_backwards("bounce_up")
	else:
		finished.emit()
