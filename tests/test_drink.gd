extends Node2D


@export var tarots: Array[Tarot]

@onready var bar: Bar = $Bar


func _ready() -> void:
	bar.load_cards(tarots)
	bar.flip_cards()
	bar.finished.connect(_handle_bar_finished)


func _handle_bar_finished(_selection: Array[Element]) -> void:
	bar.reset()
	
