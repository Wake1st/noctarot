class_name DailyQuota


var appointments: Array[Appointment]
var score: int

var current: Appointment
var index: int = 0


func next() -> Appointment:
	# no overflow
	if index == appointments.size():
		return null
	
	# set the current
	current = appointments[index]
	index += 1
	
	# unbalance attributes
	current.client.cards[0].balanced = false
	current.client.cards[4].balanced = false
	
	return current


func modify_score(scr: int) -> void:
	# score modifiers
	score += scr
	current.score = scr
	
	# every good deed reduces problems
	current.client.issues -= scr
