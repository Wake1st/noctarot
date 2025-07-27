class_name Element
extends Resource

enum Types {
	FIRE,
	AIR,
	WATER,
	EARTH
}

@export var type: Types
@export var image: Texture2D


func name() -> String:
	return Types.keys()[type]
