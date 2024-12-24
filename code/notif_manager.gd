extends Node2D
class_name ScoreManager

signal score_updated(value)

var score := 0:
	set(value):
		score = value
		score_updated.emit(score)


func spawn_notif(amount: int, pos: Vector2) -> void:
	var notif := Notif.new()
	add_child(notif)
	notif.value = amount
	notif.position = pos


func increase_score(amount: int, notif := false, pos := Constants.SCREEN_SIZE / 2) -> void:
	score += amount
	if notif:
		spawn_notif(amount, pos)
