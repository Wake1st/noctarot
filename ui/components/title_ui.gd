class_name TitleUI
extends Control


signal finished()

enum Titles {
	CHAPTER_1,
	END_OF_DAY,
	GAME_OVER
}

const CHAPTER_1 = preload("res://assets/titles/CHAPTER 1 SCREAAAAAM.png")
const END_OF_DAY = preload("res://assets/titles/end_of_day.png")
const GAME_OVER = preload("res://assets/titles/game-over.png")

@onready var rect: TextureRect = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var isOpening: bool


func display(title: Titles) -> void:
	match title:
		Titles.CHAPTER_1:
			rect.texture = CHAPTER_1
		Titles.END_OF_DAY:
			rect.texture = END_OF_DAY
		Titles.GAME_OVER:
			rect.texture = GAME_OVER
	
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
