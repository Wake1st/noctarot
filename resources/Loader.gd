class_name Loader


const TAROT_PATH: String = "res://resources/tarot/"


static func load_tarots() -> Array[Tarot]:
	var tarot: Array[Tarot] = []
	var dir_access: DirAccess = DirAccess.open(TAROT_PATH)
	if (dir_access == null):
		return []
	
	var files: PackedStringArray = dir_access.get_files()
	if (files == null): 
		return []
	
	for file_name: String in files:
		var loaded_tarot: Tarot = load(TAROT_PATH + file_name)
		if (loaded_tarot == null):
			continue
		tarot.push_back(loaded_tarot)
	
	return tarot
