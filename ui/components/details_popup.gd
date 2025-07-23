class_name DetailsPopup
extends Control


@onready var title: Label = $Title
@onready var description: Label = $Description
@onready var animation: AnimationPlayer = $AnimationPlayer


func open(tarot: Tarot) -> void:
	# set details
	title.text = tarot.name
	description.text = tarot.reversed
	
	# animate
	animation.play("display")


func close() -> void:
	animation.play_backwards("display")
