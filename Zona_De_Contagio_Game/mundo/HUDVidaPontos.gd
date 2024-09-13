extends CanvasLayer

func _ready():
	pass
	var posit: Transform2D = Transform2D(0, Vector2(0,0))
	posit.origin = Vector2(8, 5)
	posit.x = Vector2(38.5, 0)
	posit.y = Vector2(0, 2.3333)
	$LifeBar.set_global_transform(posit)

func GameOver():
	$GameOver.text = "Game Over"

func update_score(score: int):
	$ScoreLabel.text = "PONTOS: %d" % score

func update_health(health: int):
	$ProgressBar.value = clamp( health, 0, 1000)
	pass
	var aux = health / 1000.0
	aux *= 38.5
	aux = clamp( aux, 1.0, 38.5 )
	var posit: Transform2D = Transform2D(0, Vector2(0,0))
	posit.origin = Vector2(8, 5)
	posit.x = Vector2(aux, 0)
	posit.y = Vector2(0, 2.3333)
	$LifeBar.set_transform( posit )
