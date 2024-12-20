extends Node2D
class_name BubbleMaker

const WAIT_TICKS := 4

@export var BUBBLE_SCENE: PackedScene

var tick_counter := 0
var bubble_flip := false


func _physics_process(_delta: float) -> void:
	tick_counter += 1
	if tick_counter >= WAIT_TICKS:
		tick_counter = 0
		spawn_bubble()


func spawn_bubble() -> void:
	var bubble := BUBBLE_SCENE.instantiate()
	add_child(bubble)
	
	var bubble_pos := global_position
	bubble_pos.x += 4 * (-1 + 2 * int(bubble_flip))
	
	bubble.initialize(bubble_pos)
	
	bubble_flip = !bubble_flip
	
	
