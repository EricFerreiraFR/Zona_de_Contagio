extends Node2D

func random_sound():
	var r = randi() % 4
	if r == 1:
		$audio1.play()
	elif r == 2:
		$audio2.play()
	elif r == 3:
		$audio3.play()
	elif r == 4:
		$audio4.play()
