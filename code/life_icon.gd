extends TextureRect

@onready var home_pos := position.y
var y_offset := 0.0:
	set(value):
		y_offset = value
		position.y = home_pos + y_offset

func _process(delta: float) -> void:
	y_offset = move_toward(y_offset, 0, 0.1)
	y_offset *= -1


func _on_main_lives_updated(value: int) -> void:
	y_offset = 1
