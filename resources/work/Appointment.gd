class_name Appointment


var client: Client
var chapter: String
var day: int
var score: int


func _init(cli: Client, d: int, scr: int) -> void:
	client = cli
	day = d
	score = scr
	
	chapter = "%s_day_%s" % [client.name, day]
