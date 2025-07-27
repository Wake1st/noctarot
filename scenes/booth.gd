class_name Booth
extends Node2D


@onready var character: Character = $Character


func enter(client: Client) -> void:
	character.change_avatar(client.image)
	character.enter()


func exit() -> void:
	character.exit()


func pulse(score: int) -> void:
	character.pulse(score)
