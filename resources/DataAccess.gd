class_name DataAccess


static func save_user_data() -> void:
	var save_file = FileAccess.open("user://user.save", FileAccess.WRITE)
	
	#print("mainVolume: %s" % UserData.mainVolume)
	save_file.store_float(UserData.mainVolume)
	#print("musicVolume: %s" % UserData.musicVolume)
	save_file.store_float(UserData.musicVolume)
	#print("sfxVolume: %s" % UserData.sfxVolume)
	save_file.store_float(UserData.sfxVolume)
	
	#print(UserData.fileNames)
	save_file.store_var(UserData.fileNames)


static func load_user_data() -> void:
	if not FileAccess.file_exists("user://user.save"):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://user.save", FileAccess.READ)
	if save_file.eof_reached():
		# there's no data to read
		return
	
	UserData.mainVolume = save_file.get_float()
	#print("mainVolume: %s" % UserData.mainVolume)
	UserData.musicVolume = save_file.get_float()
	#print("musicVolume: %s" % UserData.musicVolume)
	UserData.sfxVolume = save_file.get_float()
	#print("sfxVolume: %s" % UserData.sfxVolume)
	
	UserData.fileNames = save_file.get_var()
	#print(UserData.fileNames)
