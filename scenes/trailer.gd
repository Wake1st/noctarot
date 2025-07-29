class_name Trailer
extends Node


signal return_to_start()

@onready var camera: SlideCamera = $SlideCamera
@onready var booth: Booth = $Booth
@onready var table: Table = $Table
@onready var bar: Bar = $Bar

@onready var pause_menu: PauseMenu = %PauseMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu
@onready var dialogue_ui: DialogueUI = %DialogueUI
@onready var title_ui: TitleUI = %TitleUI
@onready var screen_effects_ui: ScreenEffectsUI = %ScreenEffectsUI
@onready var scoreboard_ui: ScoreboardUI = %ScoreboardUI

var file: String

var passedTraining: bool
var daily: DailyQuota


func setup(fileName: String) -> void:
	file = fileName
	
	daily = DailyQuota.new()
	daily.appointments = WorkBuilder.daily_appointments()
	
	daily.next()
	dialogue_ui.start("trainer_intro")
	#dialogue_ui.start("client_intro")


func _ready() -> void:
	WorkBuilder.load()
	
	pause_menu.resume_selected.connect(_handle_pause_selected)
	pause_menu.settings_selected.connect(_handle_settings_selected)
	pause_menu.return_selected.connect(_handle_return_selected)
	
	dialogue_ui.transition.connect(_handle_dialogue_transition)
	dialogue_ui.activate.connect(_handle_dialogue_activate)
	dialogue_ui.deactivate.connect(_handle_dialogue_deactivate)
	dialogue_ui.enter.connect(_handle_dialogue_enter)
	dialogue_ui.exit.connect(_handle_dialogue_exit)
	dialogue_ui.check.connect(_handle_dialogue_check)
	dialogue_ui.client.connect(_handle_dialogue_client)
	dialogue_ui.training_ended.connect(_handle_training_ended)
	dialogue_ui.ended.connect(_handle_dialogue_ended)
	
	title_ui.finished.connect(_handle_title_finished)
	
	settings_menu.return_selected.connect(_handle_settings_return)
	settings_menu.setup()
	
	scoreboard_ui.next.connect(_handle_scoreboard_next)
	scoreboard_ui.menu.connect(_handle_scoreboard_menu)
	
	camera.transition_finished.connect(_handle_camera_transition_finished)
	
	table.setup(_handle_pause_selected)
	table.confirmed.connect(_handle_tarots_confirmed)
	
	bar.finished.connect(_handle_drink_finished)



func _process(_delta) -> void:
	if DialogueChecks.current_passed():
		dialogue_ui.start(Dialogic.VAR.next_chapter)


func _input(event) -> void:
	if event.is_action_pressed("pause"):
		dialogue_ui.toggle_pause(pause_menu.toggle_pause())


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
		"kitchen": # TODO: should be renamed to bar
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

func _handle_dialogue_enter() -> void:
	booth.enter(daily.current.client)

func _handle_dialogue_exit() -> void:
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
			scoreboard_ui.display(
				daily.current.challenged,
				daily.current.elements,
				daily.current.score
			)

func _handle_training_ended() -> void:
	passedTraining = true
	title_ui.display(TitleUI.Titles.CHAPTER_1)

func _handle_dialogue_ended() -> void:
	pass
#endregion


#region ObjectSignals
func _handle_camera_transition_finished() -> void:
	dialogue_ui.resume()
	
	match camera.state:
		camera.State.BOOTH:
			pass
		camera.State.TABLE:
			table.activate(daily.current.client.cards)
		camera.State.KITCHEN:
			bar.flip_cards()

func _handle_title_finished() -> void:
	# cleanup
	table.reset()
	bar.reset()
	
	# start day
	if daily.current:
		dialogue_ui.start(daily.next().chapter)
	else:
		return_to_start.emit()

func _handle_pause_selected() -> void:
	dialogue_ui.toggle_pause(pause_menu.toggle_pause())


func _handle_tarots_confirmed(tarots: Array[Tarot]) -> void:
	if !passedTraining:
		DialogueChecks.set_valid(DialogueChecks.Types.FINALIZED)
	else:
		DialogueChecks.set_valid(DialogueChecks.Types.FORTUNE)
	
	camera.to_booth()
	
	daily.current.challenged = tarots
	bar.load_cards(tarots)

func _handle_drink_finished(elements: Array[Element]) -> void:
	# change scene
	camera.to_booth()
	
	# set some check to true for the dialogue
	DialogueChecks.set_valid(DialogueChecks.Types.DRINK)
	
	# store elements
	daily.current.elements = elements

func _handle_scoreboard_menu() -> void:
	return_to_start.emit()

func _handle_scoreboard_next() -> void:
	# cleanup
	table.reset()
	bar.reset()
	
	# check for end of day
	var apt: Appointment = daily.next()
	if apt:
		dialogue_ui.start(apt.chapter)
	else:
		title_ui.display(TitleUI.Titles.END_OF_DAY)
#endregion


#region Internals
func _consume_drink() -> void:
	# compare each element to each tarot
	var score: int = 0
	for tarot in daily.current.challenged:
		if tarot.balanced:
			continue
		
		var matched = daily.current.elements.any(func(e): return e == tarot.element)
		if matched:
			score += 1
		else:
			score -= 1
	daily.modify_score(score)
	
	# notify dialogue
	Dialogic.VAR.score = score
	
	# user feedback
	booth.pulse(score)

func _client_checks(args: Array[String]) -> void:
	match args[0]:
		"fortune":
			DialogueChecks.currentCheck = DialogueChecks.Types.FORTUNE
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
