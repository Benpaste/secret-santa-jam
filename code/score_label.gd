extends Label


func _on_score_manager_score_updated(value: int) -> void:
	text = str(value)
