class_name Bar
extends Node2D


signal finished(elements: Array[Element])

const CARD = preload("res://cards/card.tscn")

@onready var shelf: Shelf = $Shelf
@onready var drink: Drink = $Drink
@onready var confirmation: ConfirmationUI = %ConfirmationUI
@onready var canvas: CanvasLayer = $CanvasLayer

var placeholders: Array[Placeholder]


func load_cards(tarots: Array[Tarot]) -> void:
	
	for i in tarots.size():
		# create card
		var card: Card = CARD.instantiate()
		
		# clear placeholder
		placeholders[i].reset()
		
		# load placeholder
		placeholders[i].add_child(card)
		placeholders[i].card = card
		
		card.setup(tarots[i])


func flip_cards() -> void:
	for holder: Placeholder in placeholders:
		holder.card.flip()


func reset() -> void:
	drink.reset()


func _ready() -> void:
	shelf.setup(_handle_ingredient_selected)
	drink.full.connect(_handle_drink_full)
	confirmation.selection.connect(_handle_confirmation_selection)
	
	for child in get_children():
		if child is Placeholder:
			placeholders.push_back(child)

func _handle_ingredient_selected(ingredient: Ingredient) -> void:
	drink.add(ingredient)

func _handle_drink_full() -> void:
	confirmation.open()

func _handle_confirmation_selection(value: bool) -> void:
	if value:
		finished.emit(drink.elements)
	else:
		drink.reset()
