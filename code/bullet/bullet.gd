extends Node2D
class_name Bullet

static var amount := 0

const BASE_SPEED := 1.0
const BASE_DIRECTION := 0.0

var speed := BASE_SPEED
var direction := BASE_DIRECTION:
	set(value):
		direction = wrapf(value, 0, TAU)

var hitbox := Hitbox.new()

var lifetime := 0
var friendly := false
var grazed := false

var flip := false



func _init() -> void:
	amount += 1


func _ready() -> void:
	add_to_group("bullets")
	$AnimatedSprite2D.flip_h = flip
	update_hitbox(1)


func update_hitbox(radius: int) -> void:
	hitbox.queue_free()
	hitbox = Hitbox.new(radius)
	add_child(hitbox)


func tick() -> void:
	position += Vector2.DOWN.rotated(direction) * speed
	lifetime += 1
	if lifetime > 3000:
		die()


func die() -> void:
	amount -= 1
	queue_free()


func check_touching_target(area: Rect2i, target: Entity) -> void:
	if friendly != target.friendly:
		if hitbox.touches_rect(area):
			target.take_hit(self)
