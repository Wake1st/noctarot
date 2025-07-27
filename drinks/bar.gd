class_name Bar
extends Node2D


signal finished(elements: Array[Element])

@onready var shelf: Shelf = $Shelf
@onready var drink: Drink = $Drink
@onready var confirmation: ConfirmationUI = %ConfirmationUI


func _ready() -> void:
	shelf.setup(_handle_ingredient_selected)
	drink.full.connect(_handle_drink_full)
	confirmation.selection.connect(_handle_confirmation_selection)

func _handle_ingredient_selected(ingredient: Ingredient) -> void:
	drink.add(ingredient)

func _handle_drink_full() -> void:
	confirmation.open()

func _handle_confirmation_selection(value: bool) -> void:
	if value:
		finished.emit(drink.elements)
	else:
		drink.empty()
