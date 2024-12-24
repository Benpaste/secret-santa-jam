extends Node

enum { EXPLOSION_MEGAMAN, HURT, FLASH_STAR, FLAMETHROWER, CANNON, CIRCLE, PICKUP, GRAZE, BOSS, }

var dict := {
	EXPLOSION_MEGAMAN: "res://assets/sound/explosion_megaman.wav",
	HURT: "res://assets/sound/hitSubtle.wav",
	FLASH_STAR: "res://assets/sound/click.wav",
	FLAMETHROWER: "res://assets/sound/laserShoot_high.wav",
	CANNON: "res://assets/sound/explosion_cannon.wav",
	CIRCLE: "res://assets/sound/explosion_circle.wav",
	PICKUP: "res://assets/sound/pickupCoin_bading.wav",
	GRAZE: "res://assets/sound/graze.wav",
	BOSS: "res://assets/sound/music/boss.wav",
}

var children: Array[AudioStreamPlayer] = []


func _ready() -> void:
	for string in dict.values():
		var player := AudioStreamPlayer.new()
		player.stream = load(string)
		add_child(player)
		children.append(player)


func play(index: int, volume_db := 0.0) -> void:
	if dict.has(index):
		children[index].volume_db = volume_db
		children[index].play()
