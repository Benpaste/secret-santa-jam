extends AnimatedSprite2D
class_name WhirlpoolBubble

const ANGLE_SPEED := -0.08
const RADIUS_SPEED := 1.0
const MIN_RADIUS := 10

var _home := Vector2.ZERO
var _home_aim := Vector2.ZERO
var _direction := 0.0
var _radius := 0.0


func initialize(home := Vector2.ZERO, radius := 20.0, direction := 0.0) -> void:
	_home = home
	_radius = radius
	_direction = direction
	update_position(_direction, radius)
	play("shrink")


func _physics_process(delta: float) -> void:
	
	_home = lerp(_home, _home_aim, 0.5)
	_radius = position.distance_to(_home)
	
	_radius -= RADIUS_SPEED
	_direction += ANGLE_SPEED

	
	update_position(_direction, _radius)
	if _radius <= MIN_RADIUS:
		queue_free()


func update_position(angle: float, radius: float) -> void:
	global_position = _home + radius * Vector2.RIGHT.rotated(angle)


func update_home(new_home: Vector2) -> void:
	_home_aim = new_home
