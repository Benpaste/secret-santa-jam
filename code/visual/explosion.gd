extends Node2D

const RADIUS := 24
const DELAY := 0.05
@export var explosion_frames: SpriteFrames


func explode() -> void:
	spawn_blast(Vector2.ZERO)
	
	for i in 4:
		var pos := Vector2.RIGHT.rotated(PI * i / 4.0) * RADIUS
		var delay := (1 + i) * DELAY
		spawn_blast(pos, delay)
		spawn_blast(-pos, delay)


func spawn_blast(pos: Vector2, delay := 0.0) -> void:
	if delay > 0:
		await get_tree().create_timer(delay).timeout
	var blast := AnimatedSprite2D.new()
	blast.sprite_frames = explosion_frames
	blast.position = pos
	add_child(blast)
	blast.play()
	
