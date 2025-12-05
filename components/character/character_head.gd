class_name CharacterHead
extends Sprite2D


func set_face(texture_path: String, off: Vector2) -> void:
	texture = load(texture_path)
	offset = off
