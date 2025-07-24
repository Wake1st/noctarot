class_name PauseMenu
extends Control


signal settings_selected()
signal return_selected()

@onready var animation: AnimationPlayer = $AnimationPlayer

var paused: bool


func bring_back() -> void:
	animation.play_backwards("slide-out")


func _input(event) -> void:
	if event.is_action_pressed("pause"):
		_toggle_pause()

func _on_btn_resume_pressed() -> void:
	_toggle_pause()

func _on_btn_settings_pressed():
	animation.play("slide-out")
	settings_selected.emit()

func _on_btn_menu_pressed():
	return_selected.emit()

func _toggle_pause() -> void:
	if paused:
		animation.play_backwards("slide-in")
	else:
		animation.play("slide-in")
	
	paused = !paused
