extends Node2D

@export var _personagem: PackedScene
var qtdPorGeracao = 100

var _geracao: Array[CharacterBody2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	create_generation(qtdPorGeracao)


func _process(delta):
	pass

func create_generation(qtd: int):
	_geracao.clear()
	
	var persona
	for i in range(qtd):
		persona = _personagem.instantiate() as CharacterBody2D
		#_geracao.append(persona)
		self.add_child(persona)

func _on_timer_timeout():
	for c in _geracao:
		c.queue_free()
	create_generation(qtdPorGeracao)









func updateLevel(level: int):
	pass
	
func updateRound(Round: int):
	pass

func update_score(score: int):
	pass

func update_health(health: int):
	pass
