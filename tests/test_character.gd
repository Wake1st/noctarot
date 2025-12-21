extends Node


@export var client_name: String
@export_range(-3,3) var pulse_value: int = 0

@onready var booth: Booth = $Booth

@onready var expressions: Array[String] = [ "angry", "happy", "sad" ]
@onready var poses: Array[String] = [ "crossed", "rested" ]

var express_index: int = 0
var pose_index: int = 0


func _ready() -> void:
	TextureList.load()
	
	var expression = TextureList.get_character(
		client_name + "_head_" + expressions[express_index]
	)
	booth.change_head(expression)
	
	var pose = TextureList.get_character(
		client_name + "_body_" + poses[pose_index]
	)
	booth.change_body(pose)


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_1):
		booth.enter()
	elif Input.is_key_pressed(KEY_2):
		booth.exit()
	elif Input.is_key_pressed(KEY_3):
		express_index = (express_index + 1) % expressions.size()
		var expression = TextureList.get_character(
			"rosie_head_" + expressions[express_index]
		)
		booth.change_head(expression)
	elif Input.is_key_pressed(KEY_4):
		pose_index = (pose_index + 1) % poses.size()
		var pose = TextureList.get_character(
			"rosie_body_" + poses[pose_index]
		)
		booth.change_body(pose)
	elif Input.is_key_pressed(KEY_5):
		booth.pulse(pulse_value)
	
