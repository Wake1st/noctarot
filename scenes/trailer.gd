class_name Trailer
extends Node


signal return_to_start()

@onready var camera: SlideCamera = $SlideCamera
@onready var booth: Booth = $Booth
@onready var table: Table = $Table
@onready var kitchen: Kitchen = $Kitchen

@onready var pause_menu: PauseMenu = %PauseMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu
@onready var dialogue_ui: DialogueUI = %DialogueUI
@onready var title_ui: TitleUI = %TitleUI
@onready var screen_effects_ui: ScreenEffectsUI = %ScreenEffectsUI

var file: String

var passedTraining: bool
var daily: DailyQuota
var drink_elements: Array[Element.Types]


func setup(fileName: String) -> void:
	file = fileName
	
	daily = DailyQuota.new()
	daily.appointments = WorkBuilder.daily_appointments()
	
	daily.next()
	dialogue_ui.start("intro")


func _ready() -> void:
	WorkBuilder.load()
	
	pause_menu.settings_selected.connect(_handle_settings_selected)
	pause_menu.return_selected.connect(_handle_return_selected)
	
	dialogue_ui.transition.connect(_handle_dialogue_transition)
	dialogue_ui.activate.connect(_handle_dialogue_activate)
	dialogue_ui.deactivate.connect(_handle_dialogue_deactivate)
	dialogue_ui.enter.connect(_handle_dialogue_enter)
	dialogue_ui.check.connect(_handle_dialogue_check)
	dialogue_ui.client.connect(_handle_dialogue_client)
	dialogue_ui.training_ended.connect(_handle_training_ended)
	dialogue_ui.ended.connect(_handle_dialogue_ended)
	
	title_ui.finished.connect(_handle_title_finished)
	
	settings_menu.return_selected.connect(_handle_settings_return)
	settings_menu.setup()
	
	camera.transition_finished.connect(_handle_camera_transition_finished)
	
	table.setup(_handle_pause_selected)
	table.confirmed.connect(_handle_tarots_confirmed)
	
	kitchen.setup(_handle_drink_finished)


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
	match args[0]:
		"drink":
			_consume_drink()
		"warp":
			screen_effects_ui.on()

func _handle_dialogue_deactivate(args: Array[String]) -> void:
	match args[0]:
		"warp":
			screen_effects_ui.off()

func _handle_dialogue_enter(args: Array[String]) -> void:
	booth.enter(daily.current.client)

func _handle_dialogue_leave(args: Array[String]) -> void:
	booth.exit()

func _handle_dialogue_check(args: Array[String]) -> void:
	var command = args[0]
	args.remove_at(0)
	
	match command:
		"training":
			_training_checks(args)
		"client":
			_client_checks(args)

func _handle_dialogue_client(args: Array[String]) -> void:
	match args[0]:
		"ended":
			# display some kind of score summary
			pass

func _handle_training_ended() -> void:
	passedTraining = true
	title_ui.display()

func _handle_dialogue_ended() -> void:
	print("dialogue ended")
#endregion


func _handle_camera_transition_finished() -> void:
	dialogue_ui.resume()
	
	match camera.state:
		camera.State.BOOTH:
			pass
		camera.State.TABLE:
			table.activate(daily.current.client.cards)
		camera.State.KITCHEN:
			pass

func _handle_title_finished() -> void:
	# start day
	dialogue_ui.start(daily.next().chapter)

func _handle_pause_selected() -> void:
	pause_menu._toggle_pause()


func _handle_tarots_confirmed(tarots: Array[Tarot]) -> void:
	if !passedTraining:
		DialogueChecks.set_valid(DialogueChecks.Types.FINALIZED)
	else:
		DialogueChecks.set_valid(DialogueChecks.Types.FORTUNE)
	
	camera.to_booth()
	
	daily.current.challenged = tarots

func _handle_drink_finished(elements: Array[Element.Types]) -> void:
	# change scene
	camera.to_booth()
	
	# set some check to true for the dialogue
	DialogueChecks.set_valid(DialogueChecks.Types.DRINK)
	
	# store elements
	drink_elements = elements


#region Internals
func _consume_drink() -> void:
	# compare each element to each tarot
	var score: int = 0
	for tarot in daily.current.challenged:
		if tarot.balanced:
			continue
		
		var matched = drink_elements.any(func(e): return e == tarot.element)
		if matched:
			score += 1
		else:
			score -= 1
	daily.modify_score(score)
	
	# notify dialogue
	Dialogic.VAR.score = score
	
	# user feedback

func _client_checks(args: Array[String]) -> void:
	match args[0]:
		"fortune":
			DialogueChecks.currentCheck = DialogueChecks.Types.FINALIZED
		"drink":
			DialogueChecks.currentCheck = DialogueChecks.Types.DRINK

func _training_checks(args: Array[String]) -> void:
	match args[0]:
		"deck":
			DialogueChecks.currentCheck = DialogueChecks.Types.DECK
		"hovered":
			DialogueChecks.currentCheck = DialogueChecks.Types.HOVERED
		"selected":
			DialogueChecks.currentCheck = DialogueChecks.Types.SELECTED
		"finalized":
			DialogueChecks.currentCheck = DialogueChecks.Types.FINALIZED
#endregion
