extends Node2D
class_name Hitbox

const BASE_RADIUS := 4

var radius: int
var area: Rect2i

var disabled := false:
	set(value):
		disabled = value
		
		if disabled:
			area = Rect2i(0, 0, 0, 0)
		else:
			area = create_rect(radius)
		
		queue_redraw()


func _init(radius_ := BASE_RADIUS) -> void:
	radius = radius_
	area = create_rect(radius)


func _draw() -> void:
	if disabled: return
	if !Main.DRAW_HITBOX: return
	var c := Color.RED
	c.a = 0.5
	draw_rect(area, c)


func touches_point(point: Vector2) -> bool:
	return get_global_area().has_point(point) and !disabled


func touches_rect(rect: Rect2i) -> bool:
	return get_global_area().intersects(rect) and !disabled


func get_area() -> Rect2i:
	return area


func get_global_area() -> Rect2i:
	var global_area := area
	global_area.position += Vector2i(global_position)
	return global_area


func create_rect(rect_radius: int) -> Rect2i:
	var vec := Vector2i.ONE * rect_radius
	return Rect2i(-vec, 2 * vec)
