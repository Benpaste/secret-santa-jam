extends Enemy
class_name BossAlbatross

const SIZE := Vector2(100, 60)
const INNER_JET_POS := Vector2(37, 7)
const OUTER_JET_POS := Vector2(44, 6)
const GUN_POS := Vector2(12, 4)
const MOUTH_POS := Vector2(0, 29)
const RING_INTERVAL := 130
const CANNON_INTERVAL := 120
const MOUTH_INTERVAL := 180
const FLASH_TIME := 30

@export var DECEL_BULLET_SCENE: PackedScene
@export var NEEDLE_BULLET_SCENE: PackedScene
@export var SMALL_BULLET_SCENE: PackedScene
@export var flash_frames: SpriteFrames

var arrived := false
var arrival_tick: int




func _ready() -> void:
	super._ready()
	var rect := Rect2i(-SIZE * Vector2(0.5, 1), SIZE)
	hitbox.custom_area = rect
	position.x = 70


func tick() -> void:
	handle_arrival()
	handle_figure_eight()
	handle_death_shake()
	
	handle_patterns()


func handle_arrival() -> void:
	if on_screen() and !arrived:
		if global_position.y >= 50:
			arrived = true
			arrival_tick = Main.tick_number


func handle_figure_eight() -> void:
	if arrived:
		var time := (60 + get_tick()) / 40.0
		position.x = 70 + 20 * sin(time)
		global_position.y = 50 + 10 * sin(time * 2)


func handle_death_shake() -> void:
	if !alive:
		var shake := 5
		$AnimatedSprite2D.offset.x = randi_range(-shake, shake)
		$AnimatedSprite2D.offset.y = randi_range(-shake, shake)


func handle_patterns() -> void:
	if !alive or !arrived: return
	
	fire_rings()
	fire_mouth()
	fire_lasers()


func fire_rings() -> void:
	
	var tick := get_tick()
	if (tick + FLASH_TIME) % (RING_INTERVAL * 2) == 0:
		flash(INNER_JET_POS.reflect(Vector2.UP))
	elif (tick + FLASH_TIME) % RING_INTERVAL == 0:
		flash(INNER_JET_POS)
	
	if tick % RING_INTERVAL == 0:
		var v := Vector2.ONE
		if tick % (RING_INTERVAL * 2) == 0:
			v = Vector2(-1, 1)
		bullet_spawner.spawn_bullet_ring(20, INNER_JET_POS * v, 1, 0, 0, NEEDLE_BULLET_SCENE)
		Sound.play(Sound.CIRCLE)


func fire_lasers() -> void:
	
	if is_stage_two():
	
		var tick := get_tick() - 90
		
		if (tick + FLASH_TIME) % CANNON_INTERVAL == 0:
			flash(GUN_POS)
			flash(GUN_POS.reflect(Vector2.UP))
		
		if (tick) % CANNON_INTERVAL == 0:
			Sound.play(Sound.CANNON)
			var amount := 10
			var v := Vector2.ONE
			var dir := -PI/9
			for j in 2:
				for i in amount:
					bullet_spawner.spawn_bullet(dir, lerpf(1, 3, float(i)/amount), v * GUN_POS, false, DECEL_BULLET_SCENE)
				v = Vector2(-1, 1)
				dir = -dir


func fire_mouth() -> void:
	var tick := get_tick()
	
	
	if (tick + FLASH_TIME) % 180 == 0:
		flash(MOUTH_POS)
	
	if tick <= 0: return
	
	if tick % 180 < 60:
		if tick % 3 == 0:
			Sound.play(Sound.FLAMETHROWER)
			var spread := PI/32
			var direction := get_player_direction(MOUTH_POS) + randf_range(-spread, spread)
			bullet_spawner.spawn_bullet(direction, 2, MOUTH_POS, false, SMALL_BULLET_SCENE)



func play_death() -> void:
	await get_tree().create_timer(0.4).timeout
	
	var explode_points: Array[int] = [0]
	for i in 4:
		explode_points.append(i * 15)
		explode_points.append(i * -15)
	explode_points.shuffle()
	
	for i in explode_points:
		explode(Vector2(i, 0))
		await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.hide()
	kill_bullets()


func get_tick() -> int:
	return Main.tick_number - arrival_tick - 60


func get_player_direction(point := Vector2.ZERO) -> float:
	var player: Player = get_tree().current_scene.player
	return get_angle_to(player.position - point) - (PI / 2)


func flash(pos := Vector2.ZERO) -> void:
	var sprite := AnimatedSprite2D.new()
	sprite.frames = flash_frames
	sprite.position = pos
	add_child(sprite)
	sprite.play()
	Sound.play(Sound.FLASH_STAR)


func is_stage_two() -> bool:
	return health <= 300 or true


func kill_bullets() -> void:
	for i: Bullet in get_tree().get_nodes_in_group("bullets"):
		if !i.friendly:
			spawn_pickup(i.position)
			i.queue_free()
