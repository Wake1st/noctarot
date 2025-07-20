class_name Placeholder
extends Area2D


signal selected(card: Card, value: bool)

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var details: DetailsPopup = %DetailsPopup

var card: Card
var focused: bool
var isAnimating: bool
var isSelected: bool 


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


func _input(event) -> void:
	if focused && event.is_action_pressed("select") && !card.isAnimating:
		var newSelection = !card.isSelected
		select(newSelection)
		card.select(newSelection)
		selected.emit(card, newSelection)

func _on_mouse_entered():
	if card:
		focused = true
		card.hover(true)
		details.open(card)

func _on_mouse_exited():
	if card:
		focused = false
		card.hover(false)
		details.close()

func _on_animation_player_animation_finished(_anim_name):
	isAnimating = false
