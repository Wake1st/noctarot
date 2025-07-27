class_name ConfirmationUI
extends Control


signal selection(value: bool)

@export var text: String
@export var deny: String
@export var confirm: String

@onready var label: Label = %Label
@onready var btn_no: Button = %BtnNo
@onready var btn_yes: Button = %BtnYes
@onready var animation: AnimationPlayer = $AnimationPlayer


func open() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	animation.play("slide")


func close() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	animation.play_backwards("slide")


func _ready() -> void:
	label.text = text
	btn_no.text = deny
	btn_yes.text = confirm

func _on_btn_no_pressed():
	close()
	selection.emit(false)

func _on_btn_yes_pressed():
	close()
	selection.emit(true)
