extends AnimatedSprite2D
class_name FlashSprite


const FLASH_INTERVAL := 2
var flashing := false
var flash_timer := 0
var flash_toggled := false:
	set(value):
		flash_toggled = value
		modulate.a = float(!value)


func _physics_process(delta: float) -> void:
	if flashing:
		flash_timer += 1
		if flash_timer == FLASH_INTERVAL:
			flash_timer = 0
			flash_toggled = !flash_toggled
			
	else:
		flash_timer = 0
		flash_toggled = false


func apply_flash(time: int) -> void:
	flashing = true
	await get_tree().create_timer(time / 60.0).timeout
	flashing = false


func set_direction(vector: Vector2) -> void:
	var old_frame := frame
	if vector.x == 0:
		animation = "neutral"
	elif vector.x > 0:
		animation = "right"
	else:
		animation = "left"
	if frame != old_frame:
		frame = old_frame
