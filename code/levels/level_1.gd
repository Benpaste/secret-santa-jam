extends Node2D
class_name Level

enum BgTypes {
	SURFACE,
	OCEAN,
	CITY,
}

@export var bg := BgTypes.SURFACE



func tick() -> void:
	position += Vector2.DOWN
