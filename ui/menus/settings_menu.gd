class_name SettingsMenu
extends Control


signal return_selected()

const MAIN_BUS_NAME: String = "Master"
const MUSIC_BUS_NAME: String = "Music"
const SFX_BUS_NAME: String = "Sfx"

@onready var main: HSlider = %MainSlider
@onready var music: HSlider = %MusicSlider
@onready var sfx: HSlider = %SfxSlider

@onready var animation: AnimationPlayer = $AnimationPlayer


func setup() -> void:
	# set initial values
	main.value = UserData.mainVolume
	music.value = UserData.musicVolume
	sfx.value = UserData.sfxVolume


func open() -> void:
	animation.play("slide")


func _on_main_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index(MAIN_BUS_NAME), 
		value
	)

func _on_music_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index(MUSIC_BUS_NAME), 
		value
	)

func _on_sfx_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index(SFX_BUS_NAME), 
		value
	)

func _on_btn_return_pressed():
	animation.play_backwards("slide")
	return_selected.emit()


func _on_main_slider_drag_ended(value_changed):
	if value_changed:
		UserData.mainVolume = main.value
		DataAccess.save_user_data()

func _on_music_slider_drag_ended(value_changed):
	if value_changed:
		UserData.musicVolume = music.value
		DataAccess.save_user_data()

func _on_sfx_slider_drag_ended(value_changed):
	if value_changed:
		UserData.sfxVolume = sfx.value
		DataAccess.save_user_data()
