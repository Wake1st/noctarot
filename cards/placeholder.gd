class_name Placeholder
extends Area2D


signal select_attempted(holder: Placeholder, value: bool)

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var details: DetailsPopup = %DetailsPopup

var card: Card
var focused: bool
var isAnimating: bool
var isSelected: bool 


func try_select() -> void:
	if focused && !card.isAnimating:
		select_attempted.emit(self, !isSelected)


func select() -> void:
	if isSelected:
		animation.play_backwards("slide")
	else:
		animation.play("slide")
	
	isSelected = !isSelected
	isAnimating = true
	
	card.select(isSelected)


func _on_mouse_entered():
	if card:
		focused = true
		card.hover(true)
		details.open(card.tarot)

func _on_mouse_exited():
	if card:
		focused = false
		card.hover(false)
		details.close()

func _on_animation_player_animation_finished(_anim_name):
	isAnimating = false
