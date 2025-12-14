class_name Trailer
extends Node


signal return_to_start()

@onready var camera: SlideCamera = $SlideCamera
@onready var booth: Booth = $Booth
@onready var table: Table = $Table
@onready var bar: Bar = $Bar
@onready var client_sfx: ClientSfx = $ClientSfx

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
	
	# TODO: set the character expresion and pose before setting the character
	daily.next()
	dialogue_ui.start("trainer_intro")
	#dialogue_ui.start("client_intro")


func _ready() -> void:
	WorkBuilder.load()
	TextureList.load()
	
	pause_menu.resume_selected.connect(_handle_pause_selected)
	pause_menu.settings_selected.connect(_handle_settings_selected)
	pause_menu.return_selected.connect(_handle_return_selected)
	
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
func _on_dialogue_ui_goto_booth() -> void:
	camera.to_booth()

func _on_dialogue_ui_goto_kitchen() -> void:
	# TODO: rename kitchen to bar
	camera.to_kitchen()

func _on_dialogue_ui_goto_table() -> void:
	camera.to_table()

func _on_dialogue_ui_enter() -> void:
	booth.enter(daily.current.client)

func _on_dialogue_ui_exit() -> void:
	booth.exit()

func _on_dialogue_ui_ended() -> void:
	# do we even get here?
	pass

func _on_dialogue_ui_appointment_ended() -> void:
	scoreboard_ui.display(
		daily.current.challenged,
		daily.current.elements,
		daily.current.score
		)

func _on_dialogue_ui_change_pose(client_name: String, pose_name: String) -> void:
	daily.pose_client(client_name, pose_name)

func _on_dialogue_ui_change_expression(client_name: String, expression_name: String) -> void:
	daily.express_client(client_name, expression_name)

func _on_dialogue_ui_consume_drink() -> void:
	_consume_drink()

func _on_dialogue_ui_toggle_warp(value: bool) -> void:
	if value:
		screen_effects_ui.on()
	else:
		screen_effects_ui.off()

func _on_dialogue_ui_training_ended() -> void:
	passedTraining = true
	title_ui.display(TitleUI.Titles.CHAPTER_1)
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
		# check score
		if daily.score > 0:
			title_ui.display(TitleUI.Titles.END_OF_DAY)
		else:
			title_ui.display(TitleUI.Titles.GAME_OVER)
			client_sfx.over()
#endregion


#region Internals
func _consume_drink() -> void:
	# compare each element to each tarot
	var score: int = 0
	for tarot in daily.current.challenged:
		if tarot.balanced:
			continue
		
		var matched = daily.current.elements.any(func(e): return e.type == tarot.element)
		if matched:
			score += 1
		else:
			score -= 1
	daily.modify_score(score)
	
	# notify dialogue
	Dialogic.VAR.score = score
	
	# user feedback
	booth.pulse(score)
	if score > 0:
		client_sfx.happy()
	elif score < 0:
		client_sfx.sad()
#endregion
