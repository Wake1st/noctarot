class_name SaveMenu
extends Control


signal return_selected()

const SAVE_FILE_UI = preload("res://ui/components/save_file_ui.tscn")
const FILE_CAP: int = 3
const SEP_PREFIX: String = "separator_%s"

@onready var container: VBoxContainer = %VBoxContainer
@onready var create_file_ui: CreateFileUI = %CreateFileUI
@onready var confirmation: Confirmation = $Confirmation
@onready var animation: AnimationPlayer= $AnimationPlayer

var file_selection_callable: Callable
var files: Array[String]
var file_count: int = 0

var suggestedUI: SaveFileUI


func setup(selection_callable: Callable, fileNames: Array[String]) -> void:
	file_selection_callable = selection_callable
	files = fileNames
	
	for file in files:
		_create_save_file_ui(file)


func open() -> void:
	animation.play("slide")


func _ready() -> void:
	# load save file names
	create_file_ui.created.connect(_handle_file_creation)

func _handle_file_creation(text: String) -> void:
	# check to avoid duplicate file names
	for file: String in files:
		if file == text:
			print("ERROR - matching file names")
			return
	files.push_back(text)
	
	# create an actual save file
	UserData.fileNames = files
	DataAccess.save_user_data()
	
	# create ui
	_create_save_file_ui(text)

func _handle_remove_file(file_ui: SaveFileUI) -> void:
	suggestedUI = file_ui
	confirmation.open()

func _on_btn_return_pressed():
	animation.play_backwards("slide")
	return_selected.emit()

func _create_save_file_ui(text: String) -> void:
	# insert a new file just before the create btn
	var saveFileUI: SaveFileUI = SAVE_FILE_UI.instantiate()
	var index = container.get_child_count() - 1
	
	# add the file ui
	container.add_child(saveFileUI)
	container.move_child(saveFileUI, index)
	saveFileUI.setup(text)
	saveFileUI.remove.connect(_handle_remove_file)
	saveFileUI.selected.connect(file_selection_callable)
	
	# limit amount
	file_count += 1
	if file_count == FILE_CAP:
		create_file_ui.disable(true)

func _on_confirmation_selection(value) -> void:
	if value:
		# remove the file and it's separator
		files.remove_at(files.find(suggestedUI.fileName))
		UserData.fileNames = files
		DataAccess.save_user_data()
		
		suggestedUI.queue_free()
		
		file_count -= 1
		create_file_ui.disable(false)
