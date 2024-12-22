extends Node2D
class_name Notif

const max_life := 40.0
var life := 0

var value := 0


func _physics_process(delta: float) -> void:
	life += 1
	if life > max_life:
		queue_free()
	else:
		queue_redraw()


func _draw() -> void:
	
	var gradient := life / max_life
	var pos := Vector2.UP * (1 - pow(gradient - 1, 2)) * 12
	var text := str(value)
	var color := Color.RED
	
	
	draw_string(Constants.FONT_SCORE, pos, text)
	
