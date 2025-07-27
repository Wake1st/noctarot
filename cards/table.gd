class_name Table
extends Node2D


signal confirmed(tarots: Array[Tarot])

const SELECTION_CAP: int = 3

@onready var placemat: Placemat = $Placemat
@onready var deck: Deck = $Deck
@onready var hud_ui: HudUI = %HudUI
@onready var confirmation: ConfirmationUI = %ConfirmationUI

var selected: Array[Card]


func setup(paused_callable: Callable) -> void:
	hud_ui.paused.connect(paused_callable)


func activate(tarots: Array[Tarot]) -> void:
	deck.shuffle(tarots)
	hud_ui.open()


func _ready() -> void:
	placemat.setup(_handle_card_selected)
	deck.drawn.connect(_handle_card_drawn)
	
	hud_ui.finished.connect(_handle_finished_selected)
	confirmation.selection.connect(_handle_confirmed_selected)

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

func _handle_finished_selected() -> void:
	if selected.size() == SELECTION_CAP:
		confirmation.open()

func _handle_confirmed_selected(value: bool) -> void:
	if value:
		hud_ui.close()
		
		var tarots: Array[Tarot]
		for select in selected:
			tarots.push_back(select.tarot)
		
		confirmed.emit(tarots)
