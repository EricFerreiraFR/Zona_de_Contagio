extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GameOver():
	$CanvasLayer.GameOver()

func update_score(score: int):
	$CanvasLayer.update_score(score)

func update_health(health: int):
	$CanvasLayer.update_health(health)
	#$CanvasLayer/LifeBar.rect_size.x = health * $CanvasLayer/LifeBar.texture.get_size().x
