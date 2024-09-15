extends Node2D
var count : int = 0
var round : int = 1
var level : int = 1
var player: Node 	# Recebe o player 
var quantiaZumbis : int = 10
var waitRound = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateLevel(level)
	updateRound(round)
	player = get_node("/root/Node2D/Player")
	$Timer.start()
	
	
func _on_timer_timeout():
	#tempo do round
	if waitRound == false:
		count += 1
		if count == 10: #alterar o valor
			round += 1
			updateRound(round)
			quantiaZumbis +=  randi() % 10 * level
			count = 0
			waitRound = true
	else :
		count +=1
		if count == 5:
			waitRound = false
			count = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player._score >= 1500 and level == 1:
		level = 2 
		updateLevel(level)
	elif player._score >= 3000 and level == 2:
		level = 3
	elif player._score >= 5000 and level == 3:
		level = 4
	elif player._score >= 9000 and level == 4:
		level = 5
	elif player._score >= 15000 and level == 5:
		level = 6
	pass


func GameOver():
	$HUDVidaPontos.GameOver()
	
func updateLevel(level: int):
	$HUDVidaPontos.updateLevel(level)
	
func updateRound(round: int):
	$HUDVidaPontos.updateRound(round)

func update_score(score: int):
	$HUDVidaPontos.update_score(score)

func update_health(health: int):
	$HUDVidaPontos.update_health(health)
