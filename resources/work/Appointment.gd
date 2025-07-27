class_name Appointment


var client: Client
var chapter: String
var day: int

var unbalanced: Array[Tarot]
var challenged: Array[Tarot]
var score: int


func _init(cli: Client, d: int, scr: int) -> void:
	client = cli
	day = d
	score = scr
	
	chapter = "%s_apt_%s" % [client.name, day]
