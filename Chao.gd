extends StaticBody2D

func _ready():
	set_process(true)

func _process(delta):
	if get_parent().start:
		if get_child(3).current_animation != "Move":
			get_child(3).play("Move")
	else:
		get_child(3).stop()
