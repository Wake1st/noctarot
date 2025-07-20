class_name Card
extends Node2D


@onready var animation: AnimationPlayer = $AnimationPlayer

var isAnimating: bool
var isSelected: bool


func hover(on: bool) -> void:
	# do not interrupt
	if isAnimating || isSelected:
		return
	
	if on:
		animation.play("hover")
	else:
		animation.play_backwards("hover")
	
	isAnimating = true


func flip() -> void:
	# do not interrupt
	if isAnimating:
		return
	
	animation.play("flip")
	
	isAnimating = true


func select(up: bool) -> void:
	# do not interrupt
	if isAnimating:
		return
	
	if up && !isSelected:
		animation.play("slide")
		isSelected = true
	elif isSelected:
		animation.play_backwards("slide")
		isSelected = false
	
	isAnimating = true


func _on_animation_player_animation_finished(_anim_name):
	isAnimating = false
