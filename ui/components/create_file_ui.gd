class_name CreateFileUI
extends MarginContainer


signal created(text: String)

@onready var btn_create: Button = %BtnCreate
@onready var input: LineEdit = %LineEdit
@onready var btn_cancel: Button = %BtnCancel
@onready var btn_confirm: Button = %BtnConfirm


func disable(value: bool) -> void:
	if value:
		visible = false
		btn_create.disabled = true
		btn_create.visible = false
		
		input.editable = false
		input.visible = false
		btn_cancel.disabled = true
		btn_cancel.visible = false
		btn_confirm.disabled = true
		btn_confirm.visible = false
	else:
		_reset()


func _ready() -> void:
	_reset()

func _on_btn_create_pressed() -> void:
	btn_create.disabled = true
	btn_create.visible = false
	
	input.editable = true
	input.visible = true
	btn_cancel.disabled = false
	btn_cancel.visible = true
	btn_confirm.disabled = false
	btn_confirm.visible = true
	
	# focus on input
	input.grab_focus()

func _on_btn_cancel_pressed() -> void:
	_reset()
	input.text = ""

func _on_btn_confirm_pressed() -> void:
	_create()

func _on_line_edit_text_submitted(_new_text):
	_create()

func _reset() -> void:
	visible = true
	btn_create.disabled = false
	btn_create.visible = true
	
	input.editable = false
	input.visible = false
	btn_cancel.disabled = true
	btn_cancel.visible = false
	btn_confirm.disabled = true
	btn_confirm.visible = false

func _create() -> void:
	_reset()
	
	if input.text.is_empty():
		created.emit(input.placeholder_text)
	else:
		created.emit(input.text)
	
	input.text = ""
