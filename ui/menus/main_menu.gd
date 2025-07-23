class_name MainMenu
extends Control


signal play_selected()
signal settings_selected()
signal credits_selected()

@onready var animation: AnimationPlayer = $AnimationPlayer


func open() -> void:
	animation.play_backwards("slide")


func _on_btn_play_pressed() -> void:
	animation.play("slide")
	play_selected.emit()

func _on_btn_settings_pressed() -> void:
	animation.play("slide")
	settings_selected.emit()

func _on_btn_credits_pressed() -> void:
	animation.play("slide")
	credits_selected.emit()
