
extends KinematicBody2D

onready var GRAVIDADE = -9.8

export(String) var Anim_Walk = "Walk"
export(String) var Anim_Idle = "Idle"
export(String) var Anim_Jump = "Jump"

export(String) var Anim_Hurt = "Hurt"

export(int) var Peso =  80
export(int) var Velocidade =  500

func _ready():
	set_physics_process(true)

func _gravidade(delta):
	
	
	if GRAVIDADE > -9.8:
		GRAVIDADE -= Peso * delta
	else:
		GRAVIDADE == -9.8
	
	move_and_slide(Vector2(0, GRAVIDADE * -3000 * delta), Vector2(0, -1), 25.0)

func _controles(delta):
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		get_child(4).play()
		GRAVIDADE = 18

	if is_on_floor():
		if get_child(1).current_animation != Anim_Walk:
				get_child(1).play(Anim_Walk)
	else:
		if get_child(1).current_animation != Anim_Jump:
				get_child(1).play(Anim_Jump)
				
	if Input.is_action_just_pressed("ui_down"):
		get_parent()._game_over()

func _physics_process(delta):
	_gravidade(delta)
	if get_parent().start:
		_controles(delta)
	else:
		if Input.is_action_just_pressed("ui_up") and !get_parent().gameover:
			get_parent().start = true