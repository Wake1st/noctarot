class_name ScreenEffectsUI
extends TextureRect


@onready var animation: AnimationPlayer = $AnimationPlayer


func on() -> void:
	animation.play("on")


func off() -> void:
	animation.play_backwards("on")
