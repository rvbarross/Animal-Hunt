extends AnimatedSprite

var pode_jogar = false

func _ready():
	# Toca a música de fundo.
	$BackgroundMusic.play()
	visible = true
	get_parent().get_node("Timeout").visible = false
	Socket.connect_to_server()
	


func _on_JogarBotao_pressed():
	# Troca de cena.
	pode_jogar = true
	get_parent().get_node("Pontuacao/Tempo/Dificuldade").text = str(2)
	get_parent().get_node("difMenu").selected_dif = "2"
	visible = false
	$BackgroundMusic.stop()
	get_parent()._ready()


func _on_SaitBotao_pressed():
	# Fecha o jogo.
	get_tree().quit()


func _on_dfbtn_pressed():
	# Troca de cena.
	visible = false
	get_parent().get_node("difMenu").visible = true
	$BackgroundMusic.stop()
