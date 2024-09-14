extends Node2D
var count : int = 0
var round : int = 1
var level : int = 1
var player: Node 	# Recebe o player 
var quantiaZumbis : int = 10
var waitRound = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Node2D/Player")
	$Timer.start()
	
	
func _on_timer_timeout():
	#tempo do round
	if waitRound == false:
		count += 1
		if count == 60:
			print("Acabou")
			round += 1
			quantiaZumbis =  randi() % 100 *  quantiaZumbis
			count = 0
			waitRound = true
	else :
		count +=1
		if count == 15:
			waitRound = false
			count = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player._score >= 100 and level == 1:
		level = 2 
	elif player._score >= 500 and level == 2:
		level = 3
	pass

#func updateRound(round: int):
	#$CanvasLayer.updateRound(round)

func GameOver():
	$HUDVidaPontos.GameOver()

func update_score(score: int):
	$HUDVidaPontos.update_score(score)

func update_health(health: int):
	$HUDVidaPontos.update_health(health)
	#$CanvasLayer/LifeBar.rect_size.x = health * $CanvasLayer/LifeBar.texture.get_size().x
