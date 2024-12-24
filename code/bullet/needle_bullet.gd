extends DecelBullet


func tick() -> void:
	super.tick()
	var ani: AnimatedSprite2D = $AnimatedSprite2D
	ani.rotation = snap_angle(direction)


func snap_angle(angle: float, snap := 8) -> float:
	var snapped_angle := angle + (PI / 2) + (PI / snap)
	snapped_angle = PI * int((snap / 2) * snapped_angle / PI) / (snap / 2)
	return wrapf(snapped_angle, 0, TAU)
