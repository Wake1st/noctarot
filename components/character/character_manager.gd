class_name CharacterManager
extends Node2D


@onready var character: Character = $Character
@onready var animation: AnimationPlayer = $AnimationPlayer


func enter() -> void:
	animation.play("slide")


func exit() -> void:
	animation.play_backwards("slide")
