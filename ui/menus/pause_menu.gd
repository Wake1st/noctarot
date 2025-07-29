class_name PauseMenu
extends Control


signal resume_selected()
signal settings_selected()
signal return_selected()

@onready var animation: AnimationPlayer = $AnimationPlayer

var paused: bool


func bring_back() -> void:
	animation.play_backwards("slide-out")


func toggle_pause() -> bool:
	if paused:
		animation.play_backwards("slide-in")
	else:
		animation.play("slide-in")
	
	paused = !paused
	return paused


func _on_btn_resume_pressed() -> void:
	resume_selected.emit()

func _on_btn_settings_pressed():
	animation.play("slide-out")
	settings_selected.emit()

func _on_btn_menu_pressed():
	return_selected.emit()
