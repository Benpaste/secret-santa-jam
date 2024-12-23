extends TextureRect


func set_level(level: Level) -> void:
	match level.bg:
		Level.BgTypes.SURFACE:
			texture = load("res://assets/textures/background_surface.png")
		Level.BgTypes.OCEAN:
			texture = load("res://assets/textures/background.png")
		Level.BgTypes.CITY:
			texture = load("res://assets/textures/background_city.png")
