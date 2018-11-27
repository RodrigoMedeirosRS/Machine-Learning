extends Node2D
onready var cactusSpawner = get_parent().get_child(4)
onready var dinossaur = get_parent().get_child(0)
onready var pegouCactus = false
onready var podePular = true
onready var end = false
onready var proximoCactus = 0
onready var historicoEscolar = {}

onready var inputDistancia = 0
onready var lastDistance = 0
onready var taNoChao = 0
onready var score = 0
onready var startScore = -6000
onready var tentativa = 0 

func _ready():
	var test_file = File.new()
	if OS.get_name() == "Android":
		if test_file.file_exists("user://learning.save"):
			_lembra()
	else:
		if test_file.file_exists("res://learning.save"):
			_lembra()
	set_process(true)

func _process(delta):
	get_child(1).text = "Last Distance:" + str(lastDistance) + ", Best Score:" + str(startScore) + ", Score:" + str(score)
	_pegaNovoCactus()
	_pula()
	_encerra()
	
func _pegaNovoCactus():
	if !pegouCactus:
		if cactusSpawner.get_child_count() > 1:
			for i in range (cactusSpawner.get_child_count()):
				if i > 0:
					if cactusSpawner.get_child(i).global_position.x > dinossaur.global_position.x:
						proximoCactus = cactusSpawner.get_child(i)
						inputDistancia = dinossaur.global_position.x - proximoCactus.global_position.x
						pegouCactus = true
						break
	else:
		inputDistancia =  dinossaur.global_position.x - proximoCactus.global_position.x
		if inputDistancia > dinossaur.global_position.x:
			score += 100
			pegouCactus = false

func _pula():
	if pegouCactus:
		if inputDistancia >= lastDistance and podePular and get_parent().get_child(0).is_on_floor():
			Input.action_press("ui_up")
	if dinossaur.position.y <= 102:
		podePular = false
		
	if dinossaur.is_on_floor() and !podePular:
		podePular = true

func _encerra():
	if get_parent().gameover and !end:
		score -= 6000
		if score <= startScore:
			if podePular:
				score = startScore
				lastDistance -= 0.1
				_aprende()
			else:
				score = startScore
				lastDistance += 0.1
				_aprende()
		else:
			_aprende()
		end = true

func _aprende():
	var log_files=File.new()
	if OS.get_name() == "Android":
		log_files.open("user://historico.txt", File.READ_WRITE)
	else:
		log_files.open("res://historico.txt", File.READ_WRITE)
	log_files.seek_end()
	tentativa += 1
	log_files.store_line("Tentativa: " + str(tentativa) + " Dados: " + get_child(1).text)
	log_files.close()
	
	var save_dict={
		"LastDistance" : lastDistance,
		"Pontuacao" : score,
		"Tentativa" : tentativa
	}
	var save_file=File.new()
	if OS.get_name() == "Android":
		save_file.open("user://learning.save", File.WRITE)
	else:
		save_file.open("res://learning.save", File.WRITE)
	save_file.store_line(to_json(save_dict))
	save_file.close()
	
func _lembra():
	var save_file = File.new()
	var currentline = {}
	if OS.get_name() == "Android":
		save_file.open("user://learning.save", File.READ)
	else:
		save_file.open("res://learning.save", File.READ)
	currentline = parse_json(save_file.get_line())
	lastDistance=currentline["LastDistance"]
	startScore=currentline["Pontuacao"]
	tentativa=currentline["Tentativa"]
	save_file.close()

func _on_Timer_timeout():
	Input.action_press("ui_up")
