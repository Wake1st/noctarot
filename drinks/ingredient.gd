@tool
class_name Ingredient
extends Node2D


signal selected(ingredient: Ingredient)

@export var element: Element

@onready var sprite: Sprite2D = $Sprite2D
@onready var details: DetailsPopup = %DetailsPopup

var focused: bool 


func _ready() -> void:
	name = "Ingredient_%s" % element.nickname.replace(" ", "")
	sprite.texture = element.image

func _input(event) -> void:
	if focused && event.is_action_pressed("select"):
		selected.emit(self)

func _on_area_2d_mouse_entered():
	focused = true
	details.open(element.nickname, element.description)

func _on_area_2d_mouse_exited():
	focused = false
	details.close()
