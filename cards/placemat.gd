class_name Placemat
extends Node2D


const CARD_CAP: int = 5

@export var pass_card_duration: float = 0.8

@onready var placeholder_1: Placeholder = $Placeholder1
@onready var placeholder_2: Placeholder = $Placeholder2
@onready var placeholder_3: Placeholder = $Placeholder3
@onready var placeholder_4: Placeholder = $Placeholder4
@onready var placeholder_5: Placeholder = $Placeholder5

var placeholders: Array[Placeholder]
var index: int
var nextPlace: Placeholder
var isAnimating: bool


func setup(selection_callable: Callable) -> void:
	placeholder_1.select_attempted.connect(selection_callable)
	placeholder_2.select_attempted.connect(selection_callable)
	placeholder_3.select_attempted.connect(selection_callable)
	placeholder_4.select_attempted.connect(selection_callable)
	placeholder_5.select_attempted.connect(selection_callable)
	
	for child: Placeholder in get_children():
		placeholders.push_back(child)
	nextPlace = placeholders[index]


func try_select() -> void:
	for placeholder in placeholders:
		placeholder.try_select()


func place_card(card: Card) -> void:
	# no more drawns after 5
	if index == CARD_CAP || isAnimating:
		return
	
	# pass card
	nextPlace = placeholders[index]
	var glob_pos = card.global_position - nextPlace.global_position
	card.reparent(nextPlace)
	card.position = glob_pos
	
	# animate
	var tween = create_tween()
	tween.tween_property(card, "position", Vector2.ZERO, pass_card_duration)
	tween.tween_callback(_on_placement_finished.bind(card))
	
	isAnimating = true


func _on_placement_finished(card: Card) -> void:
	# now the placehold "has" the card
	nextPlace.card = card
	
	# big reveal
	card.flip()
	
	index += 1
	isAnimating = false
