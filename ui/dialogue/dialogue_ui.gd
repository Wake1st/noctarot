class_name DialogueUI
extends Control


signal goto_booth()
signal goto_table()
signal goto_kitchen()
signal consume_drink()
signal toggle_warp(value: bool)
signal enter()
signal exit()
signal appointment_ended()
signal change_pose(client_name: String, pose_name: String)
signal change_expression(client_name: String, expression_name: String)
signal training_ended()
signal ended()


func start(chapter: String) -> void:
	Dialogic.start(chapter)


func resume() -> void:
	Dialogic.paused = false


func toggle_pause(value: bool) -> void:
	Dialogic.paused = value
	
	if value:
		Dialogic.Text.hide_textbox()
	else:
		Dialogic.Text.show_textbox()


func _ready() -> void:
	Dialogic.signal_event.connect(_handle_text_signal)
	Dialogic.timeline_ended.connect(_handle_timeline_ended)

func _handle_text_signal(argument: String) -> void:
	var args = argument.split("_")
	var command = args[0]
	args.remove_at(0)
	
	match command:
		"transition":
			Dialogic.paused = true
			
			match args[0]:
				"table":
					goto_table.emit()
				"booth":
					goto_booth.emit()
				"kitchen": # TODO: should be renamed to bar
					goto_kitchen.emit()
		"activate":
			match args[0]:
				"drink":
					consume_drink.emit()
				"warp":
					toggle_warp.emit(true)
		"deactivate":
			match args[0]:
				"warp":
					toggle_warp.emit(false)
		"enter":
			enter.emit()
		"exit":
			exit.emit()
		"check":
			match args[0]:
				"training":
					_training_checks(args[1])
				"client":
					_client_checks(args[1])
		"client":
			match args[0]:
				"ended":
					appointment_ended.emit()
		"animate":
			match args[1].to_lower(): 
				"pose":
					change_pose.emit(args[0].to_lower(), args[2].to_lower())
				"expression":
					change_expression.emit(args[0].to_lower(), args[2].to_lower())
		"training":
			training_ended.emit()


func _handle_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_handle_timeline_ended)
	ended.emit()


func _client_checks(keyword: String) -> void:
	match keyword:
		"fortune":
			DialogueChecks.currentCheck = DialogueChecks.Types.FORTUNE
		"drink":
			DialogueChecks.currentCheck = DialogueChecks.Types.DRINK


func _training_checks(keyword: String) -> void:
	match keyword:
		"deck":
			DialogueChecks.currentCheck = DialogueChecks.Types.DECK
		"hovered":
			DialogueChecks.currentCheck = DialogueChecks.Types.HOVERED
		"selected":
			DialogueChecks.currentCheck = DialogueChecks.Types.SELECTED
		"finalized":
			DialogueChecks.currentCheck = DialogueChecks.Types.FINALIZED
