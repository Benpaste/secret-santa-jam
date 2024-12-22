extends Node2D
class_name BulletSpawner

signal bullet_created(bullet: Bullet)

@export var bullet_scene: PackedScene
@export var friendly := false

var offset := 0.0


func spawn_bullet(direction := Bullet.BASE_DIRECTION, speed := Bullet.BASE_SPEED, position_ := Vector2.ZERO, flip := false, scene := bullet_scene) -> void:
	var bullet_instance: Bullet = scene.instantiate()
	bullet_instance.direction = direction
	bullet_instance.speed = speed
	bullet_instance.position = global_position + position_
	bullet_instance.friendly = friendly
	bullet_instance.flip = flip
	
	add_child(bullet_instance)
	bullet_created.emit(bullet_instance)


func spawn_bullet_ring(amount := 40, position_ := Vector2.ZERO, speed := Bullet.BASE_SPEED, direction_offset := 0.0, wait_time := 0.0) -> void:
	for i in amount:
		spawn_bullet((2*i*PI/amount) + direction_offset, speed, position_)
		if wait_time > 0: await get_tree().create_timer(wait_time).timeout
