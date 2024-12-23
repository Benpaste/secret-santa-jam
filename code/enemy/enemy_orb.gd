extends Enemy

var velocity := Vector2.ZERO


func tick() -> void:
	if alive:
		position += velocity


func play_death() -> void:
	$AnimatedSprite2D.hide()
	$ExplosionSFX.play()
	$Explosion.explode()
