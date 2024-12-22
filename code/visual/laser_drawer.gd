extends Node2D
class_name LaserDrawer

const FRAME_TIME := 3

@export var frames: SpriteFrames

var tick := -1

func _ready() -> void:
	var texture_height := 8
	
	for i in (Constants.SCREEN_SIZE.y / texture_height):
		var sprite := AnimatedSprite2D.new()
		sprite.frames = frames
		if i == 0:
			sprite.animation = "flare"
			sprite.z_index = 1
		else:
			sprite.offset.y = -(i - 0.5) * texture_height
		add_child(sprite)


func _physics_process(delta: float) -> void:
	if tick >= LaserBullet.LIFETIME:
		set_active(false)
	elif tick >= 0:
		tick += 1
		var frame := tick / FRAME_TIME
		var old_age := LaserBullet.LIFETIME + 1 - FRAME_TIME * 2
		if tick >= old_age:
			frame = abs(old_age - tick) / FRAME_TIME
		if frame > 4:
			frame = 3 + (frame - 3) % 2
		set_frame(frame)


func set_frame(frame: int) -> void:
	for sprite: AnimatedSprite2D in get_children():
		sprite.frame = frame


func set_active(active: bool) -> void:
	if active: tick = 0
	else: tick = -1
	visible = active
