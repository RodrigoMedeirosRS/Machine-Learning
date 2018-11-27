extends Node2D
var dir = false
onready var cactus = preload("res://Cactus.tscn")

func _on_cactus_timeout():
	var newCactus = cactus.instance()
	newCactus.direcao = dir
	if dir:
		dir = false
	else:
		dir = true
	add_child(newCactus)
	randomize()
	get_child(0).wait_time = rand_range(0.5, 2)
