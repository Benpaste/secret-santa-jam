extends Control

const WIDTH := Constants.SCREEN_SIZE.x - 10
const COLUMN_R := 90
const ROW_HEIGHT := 14

var font_text: Font = load("res://assets/fonts/fnt_bare.tres")
var font_score: Font = load("res://assets/fonts/fnt_score.tres")

var draw_rows := 0:
	set(value):
		draw_rows = value
		queue_redraw()

var score := 10000000
var extra := 7855400
var new_score := score
var moving := false


func _ready() -> void:
	var height := 6 + ROW_HEIGHT + 4
	for sprite: AnimatedSprite2D in get_children():
		sprite.position.x = 10
		sprite.position.y = height
		height += ROW_HEIGHT
		sprite.show()
	
	for i in 11:
		set_draw_rows(draw_rows + 1)
		
		var wait := 0.1
		var sound := Sound.PICKUP
		match i:
			0,6, 10:
				wait = 0.5
				sound = Sound.CANNON
			5, 9:
				wait = 0.3
		
		Sound.play(sound)
		await get_tree().create_timer(wait).timeout
	await get_tree().create_timer(0.2).timeout
	moving = true


func _process(delta: float) -> void:
	if moving:
		if new_score < score + extra:
			new_score = move_toward(new_score, score + extra, extra / 60)
			Sound.play(Sound.PICKUP)
			queue_redraw()



func _draw() -> void:
	var height := 10
	
	for sprite: AnimatedSprite2D in get_children():
		sprite.hide()
	
	for i in draw_rows:
		height = draw_call(i, height)


func draw_call(row: int, height: int) -> int:
	match row:
		0:
			draw_string_line("stage complete!!", height, HORIZONTAL_ALIGNMENT_CENTER)
			height += 4
		1, 2, 3, 4:
			get_child(row - 1).show()
			draw_string_line("*10", height, HORIZONTAL_ALIGNMENT_RIGHT)
		5:
			draw_string_line("graze", height, HORIZONTAL_ALIGNMENT_LEFT)
			draw_string_line("*123", height, HORIZONTAL_ALIGNMENT_RIGHT)
		6:
			height += 4
			draw_string_line("bonus", height, HORIZONTAL_ALIGNMENT_CENTER)
			height += 4
		7:
			draw_score_line("boss time", 12345600, height)
		8:
			draw_score_line("no miss", 1234567000, height)
		9:
			draw_score_line("destroy", 1234700, height)
		10:
			height += 4
			draw_score_line("total", new_score, height)
	height += ROW_HEIGHT
	return height


func draw_score_line(title: String, value: int, y_pos: int) -> void:
	draw_string_line(title, y_pos, HORIZONTAL_ALIGNMENT_LEFT)
	draw_string_line(str(value), y_pos, HORIZONTAL_ALIGNMENT_RIGHT, font_score)


func draw_string_line(string: String, height: int, alignment: HorizontalAlignment, font := font_text) -> void:
	draw_string(font, Vector2(5, height), string, alignment, WIDTH)


func set_draw_rows(new_value: int) -> void:
	#var old_value := draw_rows
	#for i in 2:
		#draw_rows = old_value
		#await get_tree().create_timer(0.016).timeout
		#draw_rows = new_value
		#await get_tree().create_timer(0.016).timeout
	draw_rows = new_value
