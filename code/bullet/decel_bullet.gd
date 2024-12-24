extends Bullet
class_name DecelBullet

var rest_speed := 0.0


func _ready() -> void:
	super._ready()
	rest_speed = speed / 3.0
	speed *= 3

func tick() -> void:
	speed = lerp(speed, rest_speed, 0.1)
	super.tick()
	
