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
	$CanvasLayer/ScoreLabel.text = "Score: %d" % score

func update_health(health: int):
	$CanvasLayer/HealthLabel.text = "Health: %d" % health
