extends Label


func _on_main_lives_updated(value: int) -> void:
	text = "*%d" % value
