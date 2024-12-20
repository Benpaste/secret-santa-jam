extends Node2D
class_name Player

const SCALE := 10

const STRAIGHT_SPEED := 20
const DIAGONAL_SPEED := 14

var v_position := Vector2i.ZERO:
	set(value):
		position = Vector2(v_position / SCALE)
		v_position = value


func _ready() -> void:
	v_position = position * SCALE


func _physics_process(delta: float) -> void:
	var input_x := Input.get_axis("ui_left", "ui_right")
	var input_y := Input.get_axis("ui_up", "ui_down")
	var input_vector := Vector2i(input_x, input_y)
	
	var speed := STRAIGHT_SPEED if is_straight(input_vector) else DIAGONAL_SPEED
	v_position += speed * input_vector



func is_straight(vector: Vector2i) -> bool:
	return 0 in [vector.x, vector.y]
