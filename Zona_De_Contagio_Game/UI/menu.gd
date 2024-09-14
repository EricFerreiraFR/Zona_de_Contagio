extends Control

@onready var curr_scene = $Main


func _ready():
	$Main/VBoxContainer/Jogar.grab_focus()

func _process(delta: float) -> void:
	pass

func change_screen(scene):
	curr_scene.visible = false
	curr_scene = scene
	curr_scene.visible = true

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://level/nivel1.tscn")

func _on_instrucoes_pressed():
	pass # Replace with function body.

func _on_creditos_pressed():
	$Creditos/Voltar.grab_focus()
	change_screen($Creditos)

func _on_sair_pressed():
	get_tree().quit()

func _on_voltar_pressed():
	change_screen($Main)
	$Main/VBoxContainer/Jogar.grab_focus()
