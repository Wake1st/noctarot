class_name SlideCamera
extends Node2D


enum State {
	BOOTH,
	TABLE,
	KITCHEN
}

signal transition_finished()

@onready var camera: Camera2D = $Camera2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var state: State


func to_booth() -> void:
	match state:
		State.TABLE:
			animation.play_backwards("booth_to_table")
		State.KITCHEN:
			animation.play_backwards("booth_to_kitchen")
	state = State.BOOTH


func to_table() -> void:
	match state:
		State.BOOTH:
			animation.play("booth_to_table")
		State.KITCHEN:
			animation.play_backwards("table_to_kitchen")
	state = State.TABLE


func to_kitchen() -> void:
	match state:
		State.BOOTH:
			animation.play("booth_to_kitchen")
		State.TABLE:
			animation.play("table_to_kitchen")
	state = State.KITCHEN


func _on_animation_player_animation_finished(_anim_name):
	transition_finished.emit()
