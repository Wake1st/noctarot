class_name Deck
extends Node2D


signal selected(card: Card)

const CARD = preload("res://cards/card.tscn")

@onready var timer: Timer = $Timer

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
		DialogueChecks.check_valid(DialogueChecks.Types.DECK)
		_draw_card()

func _on_area_2d_mouse_entered():
	focused = true

func _on_area_2d_mouse_exited():
	focused = false

func _on_timer_timeout():
	_draw_card()

func _draw_card() -> void:
	if cards.size() > 0:
		selected.emit(cards.pop_back())
		timer.start()
