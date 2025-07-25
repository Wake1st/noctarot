class_name Trailer
extends Node


signal return_to_start()

@onready var camera: SlideCamera = $SlideCamera
@onready var booth: Booth = $Booth
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu
@onready var dialogue_ui: DialogueUI = %DialogueUI
@onready var title_ui: TitleUI = %TitleUI

var file: String

var passedTraining: bool
var daily: DailyQuota


func setup(fileName: String) -> void:
	file = fileName
	
	daily = DailyQuota.new()
	daily.appointments = WorkBuilder.daily_appointments()


func _ready() -> void:
	WorkBuilder.load()
	
	pause_menu.settings_selected.connect(_handle_settings_selected)
	pause_menu.return_selected.connect(_handle_return_selected)
	
	dialogue_ui.transition.connect(_handle_dialogue_transition)
	dialogue_ui.activate.connect(_handle_dialogue_activate)
	dialogue_ui.deactivate.connect(_handle_dialogue_deactivate)
	dialogue_ui.present.connect(_handle_dialogue_present)
	dialogue_ui.enter.connect(_handle_dialogue_enter)
	dialogue_ui.check.connect(_handle_dialogue_check)
	dialogue_ui.client.connect(_handle_dialogue_client)
	dialogue_ui.training_ended.connect(_handle_training_ended)
	dialogue_ui.ended.connect(_handle_dialogue_ended)
	
	title_ui.finished.connect(_handle_title_finished)
	
	settings_menu.return_selected.connect(_handle_settings_return)
	settings_menu.setup()
	
	camera.transition_finished.connect(_handle_camera_transition_finished)
	
	dialogue_ui.start("intro")

func _process(_delta) -> void:
	if DialogueChecks.current_passed():
		dialogue_ui.start(Dialogic.VAR.next_chapter)


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
	match args[0]:
		"table":
			camera.to_table()
		"booth":
			camera.to_booth()
		"kitchen":
			camera.to_kitchen()

func _handle_dialogue_activate(args: Array[String]) -> void:
	print("dialogue activate: ", args)

func _handle_dialogue_deactivate(args: Array[String]) -> void:
	print("dialogue deactivate: ", args)

func _handle_dialogue_present(args: Array[String]) -> void:
	print("dialogue present: ", args)

func _handle_dialogue_enter(args: Array[String]) -> void:
	print("dialogue enter: ", args)

func _handle_dialogue_check(args: Array[String]) -> void:
	match args[0]:
		"deck":
			DialogueChecks.currentCheck = DialogueChecks.Types.DECK
		"hovered":
			DialogueChecks.currentCheck = DialogueChecks.Types.HOVERED
		"selected":
			DialogueChecks.currentCheck = DialogueChecks.Types.SELECTED

func _handle_dialogue_client(args: Array[String]) -> void:
	match args[0]:
		"ended":
			# display some kind of "CHAPTER 1" title screen
			pass

func _handle_training_ended() -> void:
	passedTraining = true
	title_ui.display()

func _handle_dialogue_ended() -> void:
	print("dialogue ended")
#endregion


func _handle_camera_transition_finished() -> void:
	dialogue_ui.resume()


func _handle_title_finished() -> void:
	# start day
	dialogue_ui.start(daily.appointments.pop_front().chapter)
