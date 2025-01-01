extends Entity
class_name Player

const STRAIGHT_SPEED := 2
const DIAGONAL_SPEED := 14
const SCALE := 10
const RESPAWN_INVINCIBILITY := 120
var diagonal_counter := 0

var actionable := true


var invincibility := 0:
	set(value):
		invincibility = max(0, value)

var v_position: Vector2i = position:
	set(value):
		position = Vector2(value)
		v_position = value


func _ready() -> void:
	super._ready()
	hitbox.area = Rect2i(Vector2i(-2, -7), Vector2(4, 6))


func tick() -> void:
	if !actionable: return
	
	invincibility -= 1
	
	var input_x := Input.get_axis("ui_left", "ui_right")
	var input_y := Input.get_axis("ui_up", "ui_down")
	var input_vector := Vector2i(input_x, input_y)
	
	var speed := STRAIGHT_SPEED if is_straight(input_vector) else get_diagonal_speed()
	if Input.is_action_pressed("laser"): speed /= 2
	v_position += speed * input_vector
	
	var BORDER := 8
	v_position.x = clamp(v_position.x, BORDER, Constants.SCREEN_SIZE.x - BORDER)
	v_position.y = clamp(v_position.y, BORDER, Constants.SCREEN_SIZE.y - BORDER)
	
	bullet_spawner.tick()
	#$ShipSprite.flashing = bullet_spawner.is_laser_charged()
	$ShipSprite.set_direction(input_vector)
	
	for i: Pickup in get_tree().get_nodes_in_group("pickups"):
		i.update(position)


func take_hit(bullet: Bullet) -> void:
	if !is_invincible():
		invincibility = 100000
		print("Player got hit")
		actionable = false
		$ShipSprite.hide()
		$Explosion.explode()
		Sound.play(Sound.EXPLOSION_MEGAMAN)
		await get_tree().create_timer(1.0).timeout
		var main = get_parent()
		if main.lives > 0:
			main.lives -= 1
			revive()
		else:
			main.get_node("Control/ContinueScreen").display()


func revive() -> void:
	actionable = true
	$ShipSprite.show()
	$ShipSprite.apply_flash(RESPAWN_INVINCIBILITY)
	invincibility = RESPAWN_INVINCIBILITY


func is_invincible() -> bool:
	return invincibility > 0


static func is_straight(vector: Vector2i) -> bool:
	return 0 in [vector.x, vector.y]


func get_diagonal_speed() -> int:
	diagonal_counter += 1
	var current_counter := (diagonal_counter * DIAGONAL_SPEED) / SCALE
	var old_counter := ((diagonal_counter - 1) * DIAGONAL_SPEED) / SCALE
	if (current_counter % 10) == 0: diagonal_counter = 0
	return current_counter - old_counter
