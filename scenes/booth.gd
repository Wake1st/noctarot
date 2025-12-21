class_name Booth
extends Node2D


@onready var character: Character = $Character
@onready var animation: AnimationPlayer = $AnimationPlayer


func enter() -> void:
	animation.play("slide")


func exit() -> void:
	animation.play_backwards("slide")


func change_body(text_data: CharacterTexture) -> void:
	character.change_body(text_data)


func change_head(text_data: CharacterTexture) -> void:
	character.change_head(text_data)


func pulse(score: int) -> void:
	character.pulse(score)
