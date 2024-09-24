extends Node2D

@export var _personagem: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var persona = _personagem.instantiate() as CharacterBody2D
	#persona.position = Vector2(0.0,0.0)
	self.add_child(persona)









func _process(delta):
	pass

func updateLevel(level: int):
	pass
	
func updateRound(Round: int):
	pass

func update_score(score: int):
	pass

func update_health(health: int):
	pass
