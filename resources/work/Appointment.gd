class_name Appointment


var client: Client
var chapter: String
var day: int

var unbalanced: Array[Tarot]
var challenged: Array[Tarot]
var elements: Array[Element]
var score: int


func _init(cli: Client, d: int, indecies: Array[int]) -> void:
	client = cli
	day = d
	
	chapter = "%s_apt_%s_intro" % [client.name, day]
	
	for index in indecies:
		var unique_tarot = client.cards[index].duplicate()
		unique_tarot.balanced = false
		unbalanced.push_back(unique_tarot)
		client.cards[index] = unique_tarot
