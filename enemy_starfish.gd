extends Enemy
class_name EnemyStarfish

const SHOOT_INTERVAL := 60
var shoot_timer := 0


func tick() -> void:
	shoot_timer += 1
	if shoot_timer >= SHOOT_INTERVAL:
		shoot()
		shoot_timer = 0


func shoot() -> void:
	if on_shooting_area() and alive:
		for i in 5:
			bullet_spawner.spawn_bullet_ring(5, Vector2.ZERO, 1, PI)
