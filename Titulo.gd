extends Label

func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().start:
		queue_free()
