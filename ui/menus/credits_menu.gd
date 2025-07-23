class_name CreditsMenu
extends Control


signal return_selected()

@onready var animation: AnimationPlayer = $AnimationPlayer


func open() -> void:
	animation.play("slide")


func _on_btn_return_pressed() -> void:
	animation.play_backwards("slide")
	return_selected.emit()
