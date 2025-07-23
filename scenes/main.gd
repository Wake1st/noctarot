class_name Main
extends Node


const START = preload("res://scenes/start.tscn")
const TRAILER = preload("res://scenes/trailer.tscn")

var start: Start
var trailer: Trailer


func _ready() -> void:
	start = START.instantiate()
	add_child(start)
	start.game_selected.connect(_handle_game_start)

func _handle_game_start(fileName: String) -> void:
	trailer = TRAILER.instantiate()
	add_child(trailer)
	trailer.return_to_start.connect(_handle_return_to_menu)
	trailer.setup(fileName)
	
	remove_child(start)

func _handle_return_to_menu() -> void:
	start = START.instantiate()
	add_child(start)
	start.game_selected.connect(_handle_game_start)
	
	remove_child(trailer)
