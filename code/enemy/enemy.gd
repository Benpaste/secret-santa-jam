extends Entity
class_name Enemy

signal took_hit

@export var health := 15
var alive := true:
	set(value):
		if alive and !value:
			play_death()
		alive = value
		bullet_spawner.disabled = !alive
		hitbox.disabled = !alive


func _ready() -> void:
	super._ready()
	add_to_group("enemy")


func take_hit(bullet: Bullet) -> void:
	bullet.die()
	health -= 1
	if health == 0:
		alive = false
	else:
		took_hit.emit()


func play_death() -> void:
	hide()
