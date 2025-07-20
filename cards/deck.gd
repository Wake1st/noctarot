class_name Deck
extends Node2D


signal selected(card: Card)

const CARD = preload("res://tarot/card.tscn")

var cards: Array[Card]
var focused: bool


func _ready() -> void:
	var card = CARD.instantiate()
	add_child(card)
	cards.push_back(card)

func _input(event) -> void:
	if focused && event.is_action_pressed("select"):
		selected.emit(cards[0])

func _on_area_2d_mouse_entered():
	focused = true

func _on_area_2d_mouse_exited():
	focused = false
