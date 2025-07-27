class_name ScoreboardUI
extends Control


signal menu()
signal next()

enum Selection {
	MENU,
	NEXT
}

@onready var rect: TextureRect = $TextureRect
@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var card_1: TextureRect = %Card1
@onready var card_2: TextureRect = %Card2
@onready var card_3: TextureRect = %Card3
@onready var ingredient_1: TextureRect = %Ingredient1
@onready var ingredient_2: TextureRect = %Ingredient2
@onready var ingredient_3: TextureRect = %Ingredient3
@onready var lbl_score: Label = %Score

var isOpening: bool
var selection: Selection


func display(tarots: Array[Tarot], elements: Array[Element], score: int) -> void:
	card_1.texture = tarots[0].image
	card_2.texture = tarots[1].image
	card_3.texture = tarots[2].image
	
	ingredient_1.texture = elements[0].image
	ingredient_2.texture = elements[1].image
	ingredient_3.texture = elements[2].image
	
	lbl_score.text = "%s" % score
	
	isOpening = true
	animation.play("slide")


func _on_btn_menu_pressed() -> void:
	selection = Selection.MENU
	animation.play_backwards("slide")

func _on_btn_next_pressed() -> void:
	selection = Selection.NEXT
	animation.play_backwards("slide")


func _on_animation_player_animation_finished(_anim_name):
	# nothing for the opening
	if isOpening:
		isOpening = false
		return
	
	# notify when leaving
	match selection:
		Selection.NEXT:
			next.emit()
		Selection.MENU:
			menu.emit()
