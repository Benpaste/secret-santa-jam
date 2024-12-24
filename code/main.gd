extends Node2D
class_name Main


const DRAW_HITBOX := false

signal do_tick()
signal check_collision(rect: Rect2i, friendly_target: bool)

@export var player: Player
@export var level_scene: PackedScene
var level: Level

static var tick_number := 0
static var game_started := false

static var graze_count := 0:
	set(value):
		graze_count = value
		Pickup.level = clamp((graze_count / 10) + 1, 1, 4)


func _ready() -> void:
	
	level = level_scene.instantiate()
	add_child(level)
	$Control/Bg.set_level(level)
	$Player/BubbleMaker.set_level(level)
	
	tick_number = 0
	for entity in get_entities():
		entity.bullet_spawner.bullet_created.connect(_on_bullet_created)
		do_tick.connect(entity._tick)
	do_tick.connect(level.tick)

func _physics_process(_delta: float) -> void:
	if game_started:
		do_tick.emit()
		check_all_collisions()
		check_grazes()
		tick_number += 1
	else:
		if Input.is_action_just_pressed("ui_accept"):
			$Control/Title.hide()
			game_started = true


func check_all_collisions() -> void:
	for entity in get_entities():
		check_entity_collisions(entity)


func check_entity_collisions(entity: Entity) -> void:
	var rect := entity.get_global_hitbox()
	if rect.has_area():
		check_collision.emit(rect, entity)


func check_grazes() -> void:
	for bullet: Bullet in get_tree().get_nodes_in_group("bullets"):
		if !bullet.friendly and !bullet.grazed:
			var graze_dist := 8 + bullet.hitbox.radius
			if bullet.global_position.distance_squared_to(player.global_position) < pow(graze_dist, 2):
				graze_count += 1
				Sound.play(Sound.GRAZE)
				$ScoreManager.increase_score(20)
				bullet.grazed = true


func get_entities() -> Array[Entity]:
	var out: Array[Entity] = [player]
	for enemy in get_enemies():
		out.append(enemy)
	return out


func get_enemies() -> Array[Enemy]:
	var out: Array[Enemy] = []
	for node in get_tree().get_nodes_in_group("enemy"):
		out.append(node)
	return out


func _on_bullet_created(bullet: Bullet) -> void:
	do_tick.connect(bullet.tick)
	check_collision.connect(bullet.check_touching_target)
