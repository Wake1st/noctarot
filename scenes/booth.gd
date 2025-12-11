class_name Booth
extends Node2D


@onready var character: Character = $Character
@onready var animation: AnimationPlayer = $AnimationPlayer


func enter(client: Client) -> void:
	character.change_body(client.pose)
	character.change_head(client.expression)
	
	animation.play("slide")


func exit() -> void:
	animation.play_backwards("slide")


func pulse(score: int) -> void:
	character.pulse(score)
