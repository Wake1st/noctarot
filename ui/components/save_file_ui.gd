class_name SaveFileUI
extends HSplitContainer


signal selected(file_ui: SaveFileUI)
signal remove(fileName: String)

const FILE_PREFIX: String = "save_file_ui_%s"

@onready var btn_label: Button = $BtnLabel

var fileName: String


func setup(text: String) -> void:
	fileName = text
	name = FILE_PREFIX % text
	btn_label.text = text


func _on_btn_label_pressed() -> void:
	selected.emit(fileName)

func _on_btn_trash_pressed() -> void:
	remove.emit(self)
