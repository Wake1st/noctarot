class_name TextureList


static var characters: Dictionary[String, CharacterTexture]


static func load() -> void:
	characters.set("rosie_body_crossed", preload("uid://cgnxerg0rdlae"))
	characters.set("rosie_body_rested", preload("uid://cvh14qs180wky"))
	characters.set("rosie_head_angry", preload("uid://q4klemiwqnb7"))
	characters.set("rosie_head_happy", preload("uid://cw5md1xx4y2p6"))
	characters.set("rosie_head_sad", preload("uid://d2ourx5ql7byd"))


static func get_character(name: String) -> CharacterTexture:
	return characters[name.to_lower()]
