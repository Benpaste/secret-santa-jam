extends Enemy

var velocity := Vector2.DOWN


func tick() -> void:
	if alive:
		position += velocity


func play_death() -> void:
	$AnimatedSprite2D.hide()
	$ExplosionSFX.play()
	$Explosion.explode()
	
