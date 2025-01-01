extends BulletSpawner
class_name PlayerBulletSpawner

const CHARGE_TIME := 60

const COOLDOWN := 4
const DISTANCE := 3
const SPEED := 8

@export var laser_bullet_scene: PackedScene
@export var flash_frames: SpriteFrames

var cooldown_timer := 0
var current_charge := 0


func tick() -> void:
	
	if cooldown_timer >= 0:
		cooldown_timer -= 1
		return
	
	if Input.is_action_pressed("laser"):
		if !is_laser_charged():
			if current_charge % 10 == 0:
				$Charge.play()
			current_charge += 1
			if is_laser_charged():
				flash(Vector2.UP * 8)
	elif Input.is_action_just_released("laser"):
		if is_laser_charged():
			fire_laser()
		current_charge = 0
	elif Input.is_action_pressed("gun"):
		attempt_shoot()


func attempt_shoot() -> void:
	cooldown_timer = COOLDOWN
	spawn_bullet_pair(PI, SPEED, Vector2(DISTANCE, -8))
	#spawn_bullet_pair(PI, SPEED, Vector2(DISTANCE * 2, 3))
	$Shoot.play()


func spawn_bullet_pair(direction: float, speed: int, offset: Vector2) -> void:
	var flip := true
	for v in [Vector2(1, 1), Vector2(-1, 1),]:
		spawn_bullet(direction, speed, offset * v, flip)
		flip = false


func fire_laser() -> void:
	$LaserDrawer.set_active(true)
	$Laser.play()
	spawn_bullet(0, 0, Vector2.ZERO, false, laser_bullet_scene)
	cooldown_timer = LaserBullet.LIFETIME


func is_laser_charged() -> bool:
	return current_charge >= CHARGE_TIME


func flash(pos := Vector2.ZERO) -> void:
	var sprite := AnimatedSprite2D.new()
	sprite.frames = flash_frames
	sprite.position = pos
	add_child(sprite)
	sprite.play()
	Sound.play(Sound.FLASH_STAR)
