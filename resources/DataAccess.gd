class_name DataAccess


static func save_user_data() -> void:
	var save_file = FileAccess.open("user://user.save", FileAccess.WRITE)
	
	save_file.store_float(UserData.mainVolume)
	save_file.store_float(UserData.musicVolume)
	save_file.store_float(UserData.sfxVolume)
	
	save_file.store_var(UserData.fileNames)


static func load_user_data() -> void:
	if not FileAccess.file_exists("user://user.save"):
		# We don't have a save to load.
		_default_data()
		return 
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://user.save", FileAccess.READ)
	if save_file.eof_reached():
		# there's no data to read
		_default_data()
		return
	
	UserData.mainVolume = save_file.get_float()
	UserData.musicVolume = save_file.get_float()
	UserData.sfxVolume = save_file.get_float()
	
	UserData.fileNames = save_file.get_var()


static func _default_data() -> void:
	UserData.mainVolume = 0.8
	UserData.musicVolume = 0.8
	UserData.sfxVolume = 0.6
