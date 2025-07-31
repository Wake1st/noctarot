class_name Shelf
extends Node2D


func setup(selection_callable: Callable) -> void:
	for child in get_children():
		if child is Ingredient:
			(child as Ingredient).selected.connect(selection_callable)
