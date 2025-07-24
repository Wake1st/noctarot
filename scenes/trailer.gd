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
	
	dialogue_ui.transition.connect(_handle_dialogue_transition)
	dialogue_ui.activate.connect(_handle_dialogue_activate)
	dialogue_ui.deactivate.connect(_handle_dialogue_deactivate)
	dialogue_ui.present.connect(_handle_dialogue_present)
	dialogue_ui.enter.connect(_handle_dialogue_enter)
	dialogue_ui.check.connect(_handle_dialogue_check)
	dialogue_ui.ended.connect(_handle_dialogue_ended)
	
	settings_menu.return_selected.connect(_handle_settings_return)
	settings_menu.setup()
	
	dialogue_ui.start("intro")

#region SettingsSignals
func _handle_settings_selected() -> void:
	settings_menu.open()

func _handle_settings_return() -> void:
	pause_menu.bring_back()

func _handle_return_selected() -> void:
	return_to_start.emit()
#endregion

#region DialogueSignals
func _handle_dialogue_transition(args: Array[String]) -> void:
	print("dialogue transition: ", args)

func _handle_dialogue_activate(args: Array[String]) -> void:
	print("dialogue activate: ", args)

func _handle_dialogue_deactivate(args: Array[String]) -> void:
	print("dialogue deactivate: ", args)

func _handle_dialogue_present(args: Array[String]) -> void:
	print("dialogue present: ", args)

func _handle_dialogue_enter(args: Array[String]) -> void:
	print("dialogue enter: ", args)

func _handle_dialogue_check(args: Array[String]) -> void:
	print("dialogue check: ", args)

func _handle_dialogue_ended() -> void:
	print("dialogue ended")

#endregion
