extends Node2D
class_name Main


const DRAW_HITBOX := false

signal do_tick()
signal check_collision(rect: Rect2i, friendly_target: bool)

@export var player: Player

static var tick_number := 0


func _ready() -> void:
	tick_number = 0
	for entity in get_entities():
		entity.bullet_spawner.bullet_created.connect(_on_bullet_created)
		do_tick.connect(entity._tick)


func _physics_process(_delta: float) -> void:
	do_tick.emit()
	check_all_collisions()
	tick_number += 1


func check_all_collisions() -> void:
	for entity in get_entities():
		check_entity_collisions(entity)


func check_entity_collisions(entity: Entity) -> void:
	var rect := entity.get_global_hitbox()
	if rect.has_area():
		check_collision.emit(rect, entity)


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
