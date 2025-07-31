extends Node2D


@export var cards: Array[Tarot]

@onready var table = $Table


func _ready() -> void:
	table.activate(cards)
