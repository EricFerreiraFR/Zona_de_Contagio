extends Camera2D

# Referência ao player
@export var player: NodePath

func _ready():
	# Definir o player que a câmera vai seguir
	if player != null:
		self.make_current()
		self.position_smoothing_enabled = true

		# Seguir o player
		var target = get_node(player)
		self.position = target.position
		set_process(true)

func _process(delta):
	if player == null:
		return
	var target = get_node(player)
	self.position = lerp(self.position, target.position, 0.1)
