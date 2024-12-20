extends Entity
class_name Enemy

signal took_hit

var health := 15
var alive := true:
	set(value):
		if alive and !value:
			play_death()
		alive = value
		bullet_spawner.disabled = !alive
		hitbox.disabled = !alive


func tick() -> void:
	if alive:
		position.x = round(100 * (2.0 + sin(Main.tick_number / 40.0)))
		position.y = round(200 + 20 * sin(Main.tick_number / 20.0))


func take_hit(bullet: Bullet) -> void:
	bullet.die()
	health -= 1
	if health == 0:
		alive = false
	else:
		took_hit.emit()


func play_death() -> void:
	hide()
