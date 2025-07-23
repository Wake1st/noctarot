class_name PauseMenu
extends Control


signal settings_selected()
signal return_selected()

@onready var animation: AnimationPlayer = $AnimationPlayer

var paused: bool


func bring_back() -> void:
	animation.play_backwards("slide-out")


func _input(event) -> void:
	if event.is_action_pressed("pause") && !paused:
		animation.play("slide-in")
	elif event.is_action_pressed("pause") && paused:
		_unpause()

func _on_btn_resume_pressed():
	_unpause()

func _on_btn_settings_pressed():
	animation.play("slide-out")
	settings_selected.emit()

func _on_btn_menu_pressed():
	return_selected.emit()

func _unpause() -> void:
	animation.play_backwards("slide-in")
