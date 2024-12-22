extends Bullet
class_name LaserBullet

const LIFETIME := 60
const SIZE := Vector2(30, Constants.SCREEN_SIZE.y)


func _ready() -> void:
	position = Vector2.ZERO
	get_tree().create_timer(LIFETIME / 60.0).timeout.connect(queue_free)
	super._ready()
	var rect := Rect2i(-SIZE * Vector2(0.5, 1), SIZE)
	hitbox.area = rect


func die() -> void:
	pass
