extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GameOver():
	$CanvasLayer/GameOver.text = "Game Over"

func update_score(score: int):
	$CanvasLayer/ScoreLabel.text = "PONTOS: %d" % score
	print($CanvasLayer/LifeBar.rect_size.x)

func update_health(health: int):
	# Atualiza o tamanho da lifebar baseado na vida do jogador
	$CanvasLayer/LifeBar.rect_size.x = health * $CanvasLayer/LifeBar.texture.get_size().x
	#print($CanvasLayer/LifeBar.rect_size.x)
