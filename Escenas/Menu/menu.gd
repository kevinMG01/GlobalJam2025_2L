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

