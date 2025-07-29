class_name TitleUI
extends Control


signal finished()

enum Titles {
	CHAPTER_1,
	END_OF_DAY,
}

const CHAPER_1 = preload("res://assets/titles/chaper_1.png")
const END_OF_DAY = preload("res://assets/titles/end_of_day.png")

@onready var rect: TextureRect = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var isOpening: bool


func display(title: Titles) -> void:
	match title:
		Titles.CHAPTER_1:
			rect.texture = CHAPER_1
		Titles.END_OF_DAY:
			rect.texture = END_OF_DAY
	
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
