class_name Ingredient
extends Node2D


signal selected(ingredient: Ingredient)

@onready var details: DetailsPopup = %DetailsPopup

var focused: bool 


func _input(event) -> void:
	if focused && event.is_action_pressed("select"):
		selected.emit(self)

func _on_area_2d_mouse_entered():
	focused = true
	#details.open()

func _on_area_2d_mouse_exited():
	focused = false
	#details.close()
