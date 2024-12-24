extends Entity
class_name Enemy

signal took_hit

var EXPLOSION_SCENE: PackedScene = load("res://code/visual/explosion.tscn")

@export var health := 15
var alive := true:
	set(value):
		if alive and !value:
			play_death()
			drop_pickups()
		alive = value
		bullet_spawner.disabled = !alive
		hitbox.disabled = !alive

@export var pickup_amount := 0


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
		Sound.play(Sound.HURT)
		$AnimatedSprite2D.apply_flash(10)
		took_hit.emit()


func play_death() -> void:
	$AnimatedSprite2D.hide()
	explode()


func on_screen() -> bool:
	return global_position.y > 12


func on_shooting_area() -> bool:
	return global_position.y > 12 and global_position.y < 170


func explode(pos := Vector2.ZERO) -> void:
	var explosion := EXPLOSION_SCENE.instantiate()
	add_child(explosion)
	explosion.position = pos
	explosion.explode()
	Sound.play(Sound.EXPLOSION_MEGAMAN)


func drop_pickups() -> void:
	await get_tree().create_timer(0.5)
	for i in pickup_amount:
		spawn_pickup()


func spawn_pickup(pos := global_position) -> void:
	var pickup := Pickup.new()
	add_child(pickup)
	pickup.global_position = pos
