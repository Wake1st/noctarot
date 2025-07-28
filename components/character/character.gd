class_name Character
extends Node2D


const DRAIN_GRADIENT = preload("res://components/character/drain_gradient.tres")
const BOOST_GRADIENT = preload("res://components/character/boost_gradient.tres")

@export_category("Shader Params")
@export_subgroup("Boost", "b_")
@export_range(-4,4) var b_strength: float = 0.5
@export_range(-5,5) var b_size: float = 0.1
@export_subgroup("Drain", "d_")
@export_range(-4,4) var d_strength: float = 0.5
@export_range(-5,5) var d_size: float = 0.1

@onready var avatar: Sprite2D = $Avatar
@onready var animation: AnimationPlayer = $AnimationPlayer


func change_avatar(texture: Texture2D) -> void:
	avatar.texture = texture


func enter() -> void:
	animation.play("slide")


func exit() -> void:
	animation.play_backwards("slide")


func pulse(value: int) -> void:
	if value > 0:
		(avatar.material as ShaderMaterial).set_shader_parameter("strength", b_strength * value)
		(avatar.material as ShaderMaterial).set_shader_parameter("size_effect", b_size * value)
		(avatar.material as ShaderMaterial).set_shader_parameter("color_gradient", BOOST_GRADIENT)
		
		animation.speed_scale = 0.8 / value
		animation.play("pulse")
	elif value < 0:
		(avatar.material as ShaderMaterial).set_shader_parameter("strength", d_strength * abs(value))
		(avatar.material as ShaderMaterial).set_shader_parameter("size_effect", d_size * abs(value))
		(avatar.material as ShaderMaterial).set_shader_parameter("color_gradient", DRAIN_GRADIENT)
		
		animation.speed_scale = 0.6 / abs(value)
		animation.play_backwards("pulse")
