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

@onready var body: Sprite2D = $CharacterBody
@onready var head: Sprite2D = $CharacterHead


func change_body(data: CharacterTexture) -> void:
	body.texture = load(data.texture_path)
	body.offset = data.offset


func change_head(data: CharacterTexture) -> void:
	head.texture = load(data.texture_path)
	head.offset = data.offset


func pulse(value: int) -> void:
	if value > 0:
		(body.material as ShaderMaterial).set_shader_parameter("strength", b_strength * value)
		(head.material as ShaderMaterial).set_shader_parameter("strength", b_strength * value)
		(body.material as ShaderMaterial).set_shader_parameter("size_effect", b_size * value)
		(head.material as ShaderMaterial).set_shader_parameter("size_effect", b_size * value)
		(body.material as ShaderMaterial).set_shader_parameter("color_gradient", BOOST_GRADIENT)
		(head.material as ShaderMaterial).set_shader_parameter("color_gradient", BOOST_GRADIENT)
		
	elif value < 0:
		(body.material as ShaderMaterial).set_shader_parameter("strength", d_strength * abs(value))
		(head.material as ShaderMaterial).set_shader_parameter("strength", d_strength * abs(value))
		(body.material as ShaderMaterial).set_shader_parameter("size_effect", d_size * abs(value))
		(head.material as ShaderMaterial).set_shader_parameter("size_effect", d_size * abs(value))
		(body.material as ShaderMaterial).set_shader_parameter("color_gradient", DRAIN_GRADIENT)
		(head.material as ShaderMaterial).set_shader_parameter("color_gradient", DRAIN_GRADIENT)
