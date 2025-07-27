class_name Card
extends Node2D


@onready var back: Sprite2D = $Back
@onready var face: Sprite2D = $Face
@onready var shimmer: Sprite2D = $Shimmer
@onready var animation: AnimationPlayer = $AnimationPlayer

var tarot: Tarot

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


func _ready() -> void:
	back.material = back.material.duplicate(true)
	face.material = face.material.duplicate(true)
	shimmer.material = shimmer.material.duplicate(true)

func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "flip" && !tarot.balanced:
		animation.play("flare")
	elif anim_name == "flare":
		shimmer.set_instance_shader_parameter("boost", 1.0)
	
	isAnimating = false
