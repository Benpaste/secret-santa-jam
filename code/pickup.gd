extends Node2D
class_name Pickup

const BASE_SCORE := 1000

const MAGNET_RANGE := 32
const PICKUP_RANGE := 16
const MAX_AGE := 180
const OLD_AGE := 90

const FRAMES = preload("res://code/visual/pickup.tres")
static var level := 3

var sprite: FlashSprite
var age := 0

func _ready() -> void:
	add_to_group("pickups")
	
	sprite = FlashSprite.new()
	sprite.frames = FRAMES
	top_level = true
	add_child(sprite)
	sprite.play("lv%s" % level)


func update(player_pos: Vector2) -> void:
	
	age += 1
	if age > MAX_AGE:
		queue_free()
	elif age > OLD_AGE:
		sprite.apply_flash(60)
	
	var dist_squared := position.distance_squared_to(player_pos)
	
	if dist_squared <= pow(MAGNET_RANGE, 2):
		position = lerp(position, player_pos, 0.1)
	
	if dist_squared <= pow(PICKUP_RANGE, 2):
		Sound.play(Sound.PICKUP)
		get_node("/root/Main/ScoreManager").increase_score(BASE_SCORE * level, true, global_position)
		queue_free()
