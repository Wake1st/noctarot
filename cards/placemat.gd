class_name Placemat
extends Node2D


@export var pass_card_duration: float = 0.8

@onready var placeholder_1: Placeholder = $Placeholder1
@onready var placeholder_2: Placeholder = $Placeholder2
@onready var placeholder_3: Placeholder = $Placeholder3
@onready var placeholder_4: Placeholder = $Placeholder4
@onready var placeholder_5: Placeholder = $Placeholder5

var nextPlace: Placeholder


func setup(selection_callable: Callable) -> void:
	placeholder_1.selected.connect(selection_callable)
	placeholder_2.selected.connect(selection_callable)
	placeholder_3.selected.connect(selection_callable)
	placeholder_4.selected.connect(selection_callable)
	placeholder_5.selected.connect(selection_callable)
	
	nextPlace = placeholder_1


func place_card(card: Card) -> void:
	# pass card
	var glob_pos = card.global_position - nextPlace.global_position
	card.reparent(nextPlace)
	card.position = glob_pos
	
	# animate
	var tween = create_tween()
	tween.tween_property(card, "position", Vector2.ZERO, pass_card_duration)
	tween.tween_callback(_on_placement_finished.bind(card))


func _on_placement_finished(card: Card) -> void:
	# now the placehold "has" the card
	nextPlace.card = card
	
	# big reveal
	card.flip()
