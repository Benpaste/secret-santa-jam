extends ColorRect

const BLACK := 0.0
const TOP := -1.0
const BOTTOM := 1.0


func fade(to_black: bool, down: bool, duration := 0.5) -> void:
	var start := BLACK
	var finish := BOTTOM if down else TOP
	if to_black:
		start = -finish
		finish = BLACK
	await create_tween().tween_method(set_progress, start, finish, duration).finished


func set_progress(value: float) -> void:
	material.set_shader_parameter("progress_", value)
