class_name Element
extends Resource

enum Types {
	NEUTRAL,
	FIRE,
	AIR,
	WATER,
	EARTH
}

@export var type: Types
@export var image: Texture2D
@export var nickname: String
@export var description: String
