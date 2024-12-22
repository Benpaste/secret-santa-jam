extends Node2D
class_name ScoreManager

signal score_updated(value)

var score := 0:
	set(value):
		score = value
		score_updated.emit(score)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_end"):
		increase_score(200, true)


func spawn_notif(amount: int, pos: Vector2) -> void:
	var notif := Notif.new()
	add_child(notif)
	notif.value = amount
	notif.position = pos


func increase_score(amount: int, notif := false) -> void:
	if notif:
		score += amount
		spawn_notif(amount, Constants.SCREEN_SIZE / 2)
