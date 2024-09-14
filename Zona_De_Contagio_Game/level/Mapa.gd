extends Node2D
var count : int = 0
var round : int = 1
var level : int = 1
var player: Node 	# Recebe o player 
var quantiaZumbis : int = 10
var waitRound = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	elif player._score >= 3000 and level == 2:
		level = 3
	pass

#func updateRound(round: int):
	#$CanvasLayer.updateRound(round)

func GameOver():
	$HUDVidaPontos.GameOver()
	
func updateRound(round: int):
	$HUDVidaPontos.updateRound(round)

func update_score(score: int):
	$HUDVidaPontos.update_score(score)

func update_health(health: int):
	$HUDVidaPontos.update_health(health)
	#$CanvasLayer/LifeBar.rect_size.x = health * $CanvasLayer/LifeBar.texture.get_size().x
