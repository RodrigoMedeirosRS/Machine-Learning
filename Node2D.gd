extends Area2D

var direcao = false

func _ready():
	if direcao:
		get_child(0).flip_h = true
	set_process(true)

func _process(delta):
	if get_parent().get_parent().start:
		position.x -= 410 * delta

func _on_Node2D_body_entered(body):
	if body.is_in_group("dino"):
		get_parent().get_parent()._game_over()


func _on_Timer_timeout():
	if !get_parent().get_parent().gameover:
		queue_free()
