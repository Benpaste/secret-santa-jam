extends Node2D
class_name Entity

signal tick_done

@export var friendly := false
@export var RADIUS := 5
@onready var hitbox := Hitbox.new(RADIUS)

@export var bullet_spawner: BulletSpawner


func _ready() -> void:
	add_child(hitbox)


func _tick() -> void: #protected
	tick()
	tick_done.emit()


func tick() -> void:
	pass


func get_global_hitbox() -> Rect2i:
	return hitbox.get_global_area()


func take_hit(bullet: Bullet) -> void:
	pass
