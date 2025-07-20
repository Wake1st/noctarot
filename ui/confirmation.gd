class_name Confirmation
extends Control


signal selection(value: bool)

@onready var animation: AnimationPlayer = $AnimationPlayer


func open() -> void:
	animation.play("slide")


func close() -> void:
	animation.play_backwards("slide")


func _on_btn_no_pressed():
	close()
	selection.emit(false)

func _on_btn_yes_pressed():
	close()
	selection.emit(true)
