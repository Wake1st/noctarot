class_name Table
extends Node2D


@onready var placemat: Placemat = $Placemat
@onready var deck: Deck = $Deck

var selected: Array[Card]


func _ready() -> void:
	placemat.setup(_handle_card_selected)
	deck.selected.connect(_handle_card_drawn)

func _handle_card_drawn(card: Card) -> void:
	placemat.place_card(card)

func _handle_card_selected(card: Card, value: bool) -> void:
	if value:
		selected.push_back(card)
	else:
		var index = selected.find(card)
		if index >= 0:
			selected.remove_at(index)
