class_name Shelf
extends Node2D


@onready var ingredient_1: Ingredient = $Ingredient1
@onready var ingredient_2: Ingredient = $Ingredient2
@onready var ingredient_3: Ingredient = $Ingredient3
@onready var ingredient_4: Ingredient = $Ingredient4


func setup(selection_callable: Callable) -> void:
	ingredient_1.selected.connect(selection_callable)
	ingredient_2.selected.connect(selection_callable)
	ingredient_3.selected.connect(selection_callable)
	ingredient_4.selected.connect(selection_callable)
