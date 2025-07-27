class_name Deck
extends Node2D


signal drawn(card: Card)

const CARD = preload("res://cards/card.tscn")

@onready var timer: Timer = $Timer

var cards: Array[Card]
var focused: bool


func shuffle(tarots: Array[Tarot]) -> void:
	# clear old deck
	cards.clear()
	for child in get_children():
		if child as Card:
			remove_child(child)
	
	# shuffle new deck
	for i in tarots.size():
		var card: Card = CARD.instantiate()
		card.tarot = tarots[i]
		card.z_index = i
		
		add_child(card)
		cards.push_back(card)


func _input(event) -> void:
	if focused && event.is_action_pressed("select"):
		DialogueChecks.set_valid(DialogueChecks.Types.DECK)
		_draw_card()

func _on_area_2d_mouse_entered() -> void:
	focused = true

func _on_area_2d_mouse_exited() -> void:
	focused = false

func _on_timer_timeout() -> void:
	_draw_card()

func _draw_card() -> void:
	if cards.size() > 0:
		drawn.emit(cards.pop_back())
		timer.start()
