extends Control





func _ready():
	
	pass




func _on_play_button_down():
	$play.play()
	$timPlay.start()






func _on_tim_play_timeout():
	get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_1.tscn")



func _on_creditos_button_down():
	$play.play()

#Funciones Del Menu :
 #Jugar
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_1.tscn")

#Creditos
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Creditos/Creditos.tscn")

#Salir
func _on_button_3_pressed() -> void:
	get_tree().quit()
