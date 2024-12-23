extends Entity
class_name Enemy

signal took_hit

var EXPLOSION_SCENE: PackedScene = load("res://code/visual/explosion.tscn")

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
	
	if bullet_spawner == null:
		bullet_spawner = EnemyBulletSpawner.new()
		add_child(bullet_spawner)
	
	add_to_group("enemy")


func _tick() -> void: #protected
	
	hitbox.disabled = !on_screen() or !alive
	if !on_screen():
		return
	
	tick()
	tick_done.emit()


func take_hit(bullet: Bullet) -> void:
	bullet.die()
	health -= 1
	if health == 0:
		alive = false
	else:
		took_hit.emit()


func play_death() -> void:
	$AnimatedSprite2D.hide()
	explode()


func on_screen() -> bool:
	return global_position.y > 12


func on_shooting_area() -> bool:
	return global_position.y > 12 and global_position.y < 170


func explode() -> void:
	var explosion := EXPLOSION_SCENE.instantiate()
	add_child(explosion)
	explosion.explode()
