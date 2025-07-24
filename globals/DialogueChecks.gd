class_name DialogueChecks
extends Node


enum Types {
	NONE,
	HOVERED,
	SELECTED,
}

static var Possible: Dictionary[Types, bool] ={
	Types.NONE: false,
	Types.HOVERED: false,
	Types.SELECTED: false,
}

static var currentCheck: Types


static func set_check(type: Types, value: bool) -> void:
	Possible[type] = value


static func current_passed() -> bool:
	return Possible[currentCheck]
