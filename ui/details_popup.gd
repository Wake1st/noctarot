class_name DetailsPopup
extends Control


@onready var title: Label = $Title
@onready var description: Label = $Description
@onready var animation: AnimationPlayer = $AnimationPlayer


func open(card: Card) -> void:
	# set details
	title.text = card.name
	
	# animate
	animation.play("display")


func close() -> void:
	animation.play_backwards("display")
