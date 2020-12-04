extends AnimatedSprite

var selected_dif = "undefined"

func _on_ezbtn_pressed():
	selected_dif = "1"
	visible = false
	get_parent().get_node("MenuBackground").pode_jogar = true
	get_parent()._ready()


func _on_mdbtn_pressed():
	selected_dif = "2"
	visible = false
	get_parent().get_node("MenuBackground").pode_jogar = true
	get_parent()._ready()


func _on_hdbtn_pressed():
	selected_dif = "3"
	visible = false
	get_parent().get_node("MenuBackground").pode_jogar = true
	get_parent()._ready()
