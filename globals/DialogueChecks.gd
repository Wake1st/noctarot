class_name DialogueChecks
extends Node


enum Types {
	NONE,
	DECK,
	HOVERED,
	SELECTED,
}

static var Possible: Dictionary[Types, bool] ={
	Types.NONE: false,
	Types.DECK: false,
	Types.HOVERED: false,
	Types.SELECTED: false,
}

static var currentCheck: Types


static func check_valid(type: Types) -> void:
	Possible[type] = true


static func current_passed() -> bool:
	if Possible[currentCheck]:
		Possible[currentCheck] = false
		return true
	else:
		return false
