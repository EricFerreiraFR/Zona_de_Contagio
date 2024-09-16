extends Control

@onready var curr_scene = $Main


func _ready():
	$Main/VBoxContainer/Jogar.grab_focus()

func _process(delta: float) -> void:
	if ($music.playing == false):
		$music.playing = true

func change_screen(scene):
	curr_scene.visible = false
	curr_scene = scene
	curr_scene.visible = true

func _on_jogar_pressed():
	_clickAudio()
	get_tree().change_scene_to_file("res://level/mundoFinal.tscn")

func _clickAudio():
	$Main/VBoxContainer/Click.play()

func _on_instrucoes_pressed():
	_clickAudio()
	$Instrucoes/Voltar.grab_focus()
	change_screen($Instrucoes)

func _on_creditos_pressed():
	_clickAudio()
	$Creditos/Voltar.grab_focus()
	change_screen($Creditos)

func _on_sair_pressed():
	_clickAudio()
	get_tree().quit()

func _on_voltar_pressed():
	_clickAudio()
	change_screen($Main)
	$Main/VBoxContainer/Jogar.grab_focus()
