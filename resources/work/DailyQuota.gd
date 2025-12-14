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


func pose_client(client_name: String, pose_name: String) -> void:
	var appointment = _get_appointment(client_name)
	appointment.client.pose = TextureList.get_character(
		client_name + "_pose_" + pose_name
	)


func express_client(client_name: String, expression_name: String) -> void:
	var appointment = _get_appointment(client_name)
	appointment.client.expression = TextureList.get_character(
		client_name + "_expression_" + expression_name
	)


func _get_appointment(client_name: String) -> Appointment:
	var app_index: int = appointments.find_custom(func(app):
		return app.client.name.to_lower() == client_name.to_lower()
	)
	return appointments[app_index]
