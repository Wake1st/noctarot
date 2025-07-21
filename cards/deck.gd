class_name Deck
extends Node2D


signal selected(card: Card)

const CARD = preload("res://cards/card.tscn")

var cards: Array[Card]
var focused: bool


func _ready() -> void:
	# get the tarot types
	var tarots: Array[Tarot] = Loader.load_tarots()
	
	for i in tarots.size():
		var card: Card = CARD.instantiate()
		card.tarot = tarots[i]
		card.z_index = i
		
		add_child(card)
		cards.push_back(card)

func _input(event) -> void:
	if focused && event.is_action_pressed("select"):
		selected.emit(cards.pop_back())

func _on_area_2d_mouse_entered():
	focused = true

func _on_area_2d_mouse_exited():
	focused = false
