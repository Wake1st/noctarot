class_name Trailer
extends Node


signal return_to_start()

@onready var booth: Booth = $Booth
@onready var dialogue_ui: DialogueUI = %DialogueUI
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu

var file: String


func setup(fileName: String) -> void:
	file = fileName


func _ready() -> void:
	pause_menu.settings_selected.connect(_handle_settings_selected)
	pause_menu.return_selected.connect(_handle_return_selected)
	settings_menu.return_selected.connect(_handle_settings_return)
	
	settings_menu.setup()

func _handle_settings_selected() -> void:
	settings_menu.open()

func _handle_settings_return() -> void:
	pause_menu.bring_back()

func _handle_return_selected() -> void:
	return_to_start.emit()
