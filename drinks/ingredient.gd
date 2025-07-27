class_name Ingredient
extends Node2D


signal selected(ingredient: Ingredient)

@export var element: Element.Types
@export var nickname: String
@export var description: String

@export var image: Texture2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var details: DetailsPopup = %DetailsPopup

var focused: bool 


func _ready() -> void:
	sprite.texture = image

func _input(event) -> void:
	if focused && event.is_action_pressed("select"):
		selected.emit(self)

func _on_area_2d_mouse_entered():
	focused = true
	details.open(nickname, description)

func _on_area_2d_mouse_exited():
	focused = false
	details.close()
