extends Node2D
class_name ClawTest

const SEGMENT_AMOUNT := 2

@export var CLAW: Sprite2D
@export var SHOULDER: Sprite2D
@export var SEGMENT_PARENT: Node2D
@export var SEGMENT_TEXTURE: Texture

var time := 0.0


func _ready() -> void:
	create_segments(SEGMENT_AMOUNT)


func _physics_process(delta: float) -> void:
	
	time += delta
	CLAW.position.x = 50 + 10 * sin(time * 5)
	CLAW.position.y = 50 + 10 * cos(time * 5)
	
	process_segments()


func create_segments(amount: int) -> void:
	for i in amount:
		var segment := Sprite2D.new()
		segment.texture = SEGMENT_TEXTURE
		SEGMENT_PARENT.add_child(segment)


func process_segments() -> void:
	var start_pos := SHOULDER.position
	var end_pos := CLAW.position
	
	for i in SEGMENT_AMOUNT:
		var segment: Sprite2D = SEGMENT_PARENT.get_child(i)
		
		var gradient := (i + 1.0) / (SEGMENT_AMOUNT + 1.0)
		segment.position = lerp(start_pos, end_pos, gradient)
		segment.position.x += 10 * quadratic(gradient)


func quadratic(x: float) -> float:
	return 4 * x * (x - 1)
