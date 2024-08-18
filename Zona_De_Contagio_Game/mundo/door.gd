extends AnimatableBody2D

var is_open = false

func _ready():
	# Initialize the door's state
	if is_open:
		open_door()
	else:
		close_door()

func toggle_door():
	if is_open:
		close_door()
	else:
		open_door()

func open_door():
	is_open = true
	$AnimatedSprite2D.play("Open")
	# Optional: Disable collision when the door is open
	$CollisionShape2D.disabled = true

func close_door():
	is_open = false
	$AnimatedSprite2D.play("Close")
	# Optional: Enable collision when the door is closed
	$CollisionShape2D.disabled = false
