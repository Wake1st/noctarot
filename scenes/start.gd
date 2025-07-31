class_name Start
extends Node


signal game_selected(fileName: String)

@onready var main_menu: MainMenu = %MainMenu
@onready var save_menu: SaveMenu = %SaveMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu
@onready var credits_menu: CreditsMenu = %CreditsMenu


func _ready() -> void:
	main_menu.play_selected.connect(_handle_play_selected)
	main_menu.settings_selected.connect(_handle_settings_selected)
	main_menu.credits_selected.connect(_handle_credits_selected)
	
	save_menu.return_selected.connect(_handle_return_selected)
	settings_menu.return_selected.connect(_handle_return_selected)
	credits_menu.return_selected.connect(_handle_return_selected)
	
	settings_menu.setup()
	save_menu.setup(_handle_file_selected, UserData.fileNames)

func _handle_return_selected() -> void:
	main_menu.open()

func _handle_play_selected() -> void:
	save_menu.open()

func _handle_settings_selected() -> void:
	settings_menu.open()

func _handle_credits_selected() -> void:
	credits_menu.open()

func _handle_file_selected(fileName: String) -> void:
	game_selected.emit(fileName)
