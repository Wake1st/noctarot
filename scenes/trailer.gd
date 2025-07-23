class_name Trailer
extends Node


signal return_to_start()

var file: String


func setup(fileName: String) -> void:
	file = fileName


func _handle_end_session() -> void:
	return_to_start.emit()
