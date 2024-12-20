extends BulletSpawner
class_name PlayerBulletSpawner

const COOLDOWN := 4
const DISTANCE := 2
const SPEED := 8

var cooldown_timer := 0


func attempt_shoot() -> void:
	if cooldown_timer <= 0:
		cooldown_timer = COOLDOWN
		#Sound.play(Sound.FRIENDLY_SHOT, -5.0)
		spawn_bullet_pair(PI, SPEED, Vector2(DISTANCE, 0))
		spawn_bullet_pair(PI, SPEED, Vector2(DISTANCE + 3, 3))
	else:
		cooldown_timer -= 1
		#spawn_bullet_pair(PI, 10, cooldown_timer*4)


func spawn_bullet_pair(direction: float, speed: int, offset: Vector2) -> void:
	var flip := true
	for v in [Vector2(1, 1), Vector2(-1, 1),]:
		spawn_bullet(direction, speed, offset * v, flip)
		flip = false
