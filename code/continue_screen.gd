extends Label

signal finished(continued: bool)


var continue_time := 0:
	set(value):
		if visible:
			text = "press start\nto continue\n%s" % value
			continue_time = value
			if value <= 0:
				hide()
				finished.emit(false)
			else:
				$Timer.start()


func display() -> void:
	show()
	continue_time = 10


func _on_timer_timeout() -> void:
	continue_time -= 1


func _physics_process(delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("ui_accept"):
			hide()
			finished.emit(true)
		if Input.is_action_just_pressed("gun"):
			continue_time -= 1
