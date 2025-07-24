class_name DialogueUI
extends Control


signal transition(args: Array[String])
signal activate(args: Array[String])
signal deactivate(args: Array[String])
signal present(args: Array[String])
signal enter(args: Array[String])
signal check(args: Array[String])
signal ended()

func start(chapter: String) -> void:
	Dialogic.start(chapter)
	Dialogic.signal_event.connect(_handle_text_signal)
	Dialogic.timeline_ended.connect(_handle_timeline_ended)
	
	get_viewport().set_input_as_handled()


func check_passed() -> void:
	Dialogic.paused = false


func _handle_text_signal(argument: String) -> void:
	var args = argument.split("_")
	var command = args[0]
	args.remove_at(0)
	
	match command:
		"transition":
			transition.emit(args)
		"activate":
			activate.emit(args)
		"deactivate":
			deactivate.emit(args)
		"present":
			present.emit(args)
		"enter":
			enter.emit(args)
		"check":
			Dialogic.paused = true
			check.emit(args)

func _handle_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_handle_timeline_ended)
	ended.emit()
