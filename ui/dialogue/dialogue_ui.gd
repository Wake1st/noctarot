class_name DialogueUI
extends Control


func _ready() -> void:
	Dialogic.start('luna')
	get_viewport().set_input_as_handled()
