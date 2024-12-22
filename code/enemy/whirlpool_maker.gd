extends Node2D
class_name WhirlpoolMaker

const WAIT := 2
const AMOUNT := 8
const RADIUS := 40

@export var BUBBLE_SCENE: PackedScene

var tick_counter := 0
var index := 0
var bubble_flip := false


func _physics_process(_delta: float) -> void:
	tick_counter = (tick_counter + 1) % WAIT
	if tick_counter == 0:
		index = (index + 1) % AMOUNT
		spawn_bubble(index)
	
	for bubble: WhirlpoolBubble in get_children():
		bubble.update_home(global_position)


func spawn_bubble(index: float) -> void:
	var bubble: WhirlpoolBubble = BUBBLE_SCENE.instantiate()
	add_child(bubble)
	var bubble_dir := TAU * (index + 1) / AMOUNT
	bubble.initialize(global_position, RADIUS, bubble_dir)
