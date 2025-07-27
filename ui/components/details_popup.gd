class_name DetailsPopup
extends Control


@onready var title: Label = $Title
@onready var description: Label = $Description
@onready var animation: AnimationPlayer = $AnimationPlayer


func open(txt: String, des: String) -> void:
	# set details
	title.text = txt
	description.text = des
	
	# animate
	animation.play("display")


func close() -> void:
	animation.play_backwards("display")
