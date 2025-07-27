class_name DialogueChecks


enum Types {
	NONE,
	DECK,
	HOVERED,
	SELECTED,
	FINALIZED,
	FORTUNE,
	DRINK,
}

static var Possible: Dictionary[Types, bool] ={
	Types.NONE: false,
	Types.DECK: false,
	Types.HOVERED: false,
	Types.SELECTED: false,
	Types.FINALIZED: false,
	Types.FORTUNE: false,
	Types.DRINK: false,
}

static var currentCheck: Types


static func set_valid(type: Types) -> void:
	Possible[type] = true


static func current_passed() -> bool:
	if Possible[currentCheck]:
		Possible[currentCheck] = false
		return true
	else:
		return false
