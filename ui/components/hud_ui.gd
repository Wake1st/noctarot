class_name HudUI
extends Control


signal finished()
signal paused()

@onready var btn_finished: Button = $BtnFinished
@onready var btn_paused: Button = $BtnPaused
@onready var animation: AnimationPlayer = $AnimationPlayer


func open() -> void:
	animation.play("slide")


func close() -> void:
	animation.play_backwards("slide")


func _on_btn_finished_pressed() -> void:
	finished.emit()

func _on_btn_paused_pressed() -> void:
	paused.emit()
