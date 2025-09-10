class_name DetailsPopup
extends Control


@onready var title: Label = $Title
@onready var description: Label = $Description
@onready var animation: AnimationPlayer = $AnimationPlayer


func open(txt: String, des: String, downward: bool = false) -> void:
	# set details
	title.text = txt
	description.text = des
	
	# animate
	animation.play("down_display")
	#if downward:
	#else:
		#animation.play("display")


func close() -> void:
	animation.play_backwards("down_display")
