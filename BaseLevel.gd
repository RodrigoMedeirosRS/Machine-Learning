extends Node2D
onready var die = preload("res://Hit_00.wav")
onready var start = false
onready var gameover = false

func _ready():
	set_physics_process(true)

func _process(delta):
	if start and !get_child(3).playing:
		get_child(3).play()

func _game_over():
	gameover = true
	start = false
	get_child(3).stream = die
	get_child(3).play()
	if get_child(0).get_child(1).current_animation != "Hurt":
		get_child(0).get_child(1).play("Hurt")
	get_child(1).start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()
