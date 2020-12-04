extends AnimatedSprite


func _ready():
	# Toca a música de fundo.
	$BackgroundMusic.play()


func _on_JogarBotao_pressed():
	$BackgroundMusic.stop()
	get_tree().change_scene("res://Game.tscn")


func _on_SaitBotao_pressed():
	get_tree().quit()
