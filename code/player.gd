extends Entity
class_name Player

const STRAIGHT_SPEED := 2
const DIAGONAL_SPEED := 14
const SCALE := 10
var diagonal_counter := 0

var v_position := Vector2i.ZERO:
	set(value):
		position = Vector2(value)
		v_position = value


func _ready() -> void:
	v_position = position


func tick() -> void:
	var input_x := Input.get_axis("ui_left", "ui_right")
	var input_y := Input.get_axis("ui_up", "ui_down")
	var input_vector := Vector2i(input_x, input_y)
	
	var speed := STRAIGHT_SPEED if is_straight(input_vector) else get_diagonal_speed()
	v_position += speed * input_vector
	
	v_position.x = clamp(v_position.x, 0, Main.SCREEN_SIZE.x)
	v_position.y = clamp(v_position.y, 0, Main.SCREEN_SIZE.y)
	
	if Input.is_action_pressed("ui_accept"):
		bullet_spawner.attempt_shoot()


func take_hit(bullet: Bullet) -> void:
	print("Player got hit")

	


static func is_straight(vector: Vector2i) -> bool:
	return 0 in [vector.x, vector.y]


func get_diagonal_speed() -> int:
	diagonal_counter += 1
	var current_counter := (diagonal_counter * DIAGONAL_SPEED) / SCALE
	var old_counter := ((diagonal_counter - 1) * DIAGONAL_SPEED) / SCALE
	if (current_counter % 10) == 0: diagonal_counter = 0
	return current_counter - old_counter
	
