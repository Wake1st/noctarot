class_name WorkBuilder


enum People {
	TRAINER,
	ALTAS,
	COSMO,
	LUNA,
	REDD,
	ROSIE,
	SERITH,
}

const TRAINER = preload("res://resources/work/client/trainer.tres")
const ALTAS = preload("res://resources/work/client/altas.tres")
const COSMO = preload("res://resources/work/client/cosmo.tres")
const LUNA = preload("res://resources/work/client/luna.tres")
const REDD = preload("res://resources/work/client/redd.tres")
const ROSIE = preload("res://resources/work/client/rosie.tres")
const SERITH = preload("res://resources/work/client/serith.tres")

static var clients: Dictionary[People, Client] = {
	People.TRAINER: null,
	People.ALTAS: null,
	People.COSMO: null,
	People.LUNA: null,
	People.REDD: null,
	People.ROSIE: null,
	People.SERITH: null,
}

static func load() -> void:
	clients[People.TRAINER] = TRAINER
	clients[People.LUNA] = LUNA
	clients[People.REDD] = REDD
	clients[People.ROSIE] = ROSIE


static func daily_appointments() -> Array[Appointment]:
	var appointments: Array[Appointment] = []
	
	appointments.push_back(Appointment.new(clients[People.TRAINER], 1, [2]))
	appointments.push_back(Appointment.new(clients[People.ROSIE], 1, [1,3]))
	appointments.push_back(Appointment.new(clients[People.LUNA], 1, [0,2,4]))
	appointments.push_back(Appointment.new(clients[People.REDD], 1, [1,2,3,4]))
	
	return appointments
