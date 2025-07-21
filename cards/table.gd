class_name Table
extends Node2D


const SELECTION_CAP: int = 3

@onready var placemat: Placemat = $Placemat
@onready var deck: Deck = $Deck

var selected: Array[Card]


func _ready() -> void:
	placemat.setup(_handle_card_selected)
	deck.selected.connect(_handle_card_drawn)

func _input(event) -> void:
	if event.is_action_pressed("select"):
		placemat.try_select()

func _handle_card_drawn(card: Card) -> void:
	placemat.place_card(card)

func _handle_card_selected(placeholder: Placeholder, value: bool) -> void:
	if value && selected.size() < SELECTION_CAP:
		selected.push_back(placeholder.card)
		placeholder.select()
	elif !value:
		placeholder.select()
		var index = selected.find(placeholder.card)
		if index >= 0:
			selected.remove_at(index)
