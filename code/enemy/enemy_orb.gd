extends Enemy

var velocity := Vector2.ZERO


func tick() -> void:
	if alive:
		position += velocity
