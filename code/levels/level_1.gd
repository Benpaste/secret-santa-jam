extends Node2D
class_name Level

enum BgTypes {
	SURFACE,
	OCEAN,
	CITY,
}

@export var bg := BgTypes.SURFACE


func tick() -> void:
	if Main.tick_number == 1:
		Sound.play(Sound.BOSS)
	position += Vector2.DOWN
