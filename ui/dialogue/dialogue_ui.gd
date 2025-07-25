class_name DialogueUI
extends Control


signal transition(args: Array[String])
signal activate(args: Array[String])
signal deactivate(args: Array[String])
signal present(args: Array[String])
signal enter(args: Array[String])
signal check(args: Array[String])
signal client(args: Array[String])
signal training_ended()
signal ended()


func start(chapter: String) -> void:
	Dialogic.start(chapter)


func resume() -> void:
	Dialogic.paused = false


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
			check.emit(args)
		"client":
			client.emit(args)
		"training":
			training_ended.emit()

func _handle_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_handle_timeline_ended)
	ended.emit()
