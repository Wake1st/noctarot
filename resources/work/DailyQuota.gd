class_name DailyQuota


var appointments: Array[Appointment]
var score: int

var current: Appointment
var index: int = 0


func next() -> Appointment:
	# no overflow
	if index == appointments.size():
		current = null
		return null
	
	# set the current
	current = appointments[index]
	index += 1
	
	return current


func modify_score(scr: int) -> void:
	# score modifiers
	score += scr
	current.score = scr
	
	# every good deed reduces problems
	current.client.issues -= scr


func animate_client(args: Array[String]) -> void:
	var full_name: String = args.reduce(func(a,b): 
		return a + "_" + b
	)
	
	var app_index: int = appointments.find_custom(func(app):
		return app.client.name.to_lower() == args[0].to_lower()
	)
	var appointment: Appointment = appointments[app_index]
	
	match args[1].to_lower():
		"pose":
			appointment.client.pose = TextureList.get_character(full_name)
		"expression":
			appointment.client.expression = TextureList.get_character(full_name)
