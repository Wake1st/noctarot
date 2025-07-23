class_name DialogueUI
extends Control


func start(chapter: String) -> void:
	Dialogic.start(chapter)
	get_viewport().set_input_as_handled()
