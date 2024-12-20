extends AnimatedSprite2D

var velocity := Vector2.DOWN * 3


func initialize(pos := Vector2.ZERO, lifetime := 0.2) -> void:
	position = pos
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	play("shrink")


func _physics_process(delta: float) -> void:
	position += velocity
	velocity = velocity.move_toward(Vector2.DOWN * 1.5, 1)
