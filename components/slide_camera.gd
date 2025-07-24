class_name SlideCamera
extends Node2D


signal transition_finished()

@onready var camera: Camera2D = $Camera2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var isUp: bool = true


func down() -> void:
	if isUp:
		animation.play("slide")


func up() -> void:
	if !isUp:
		animation.play_backwards("slide")


func _on_animation_player_animation_finished(_anim_name):
	transition_finished.emit()
	isUp = is_equal_approx(position.y, 0.0)
