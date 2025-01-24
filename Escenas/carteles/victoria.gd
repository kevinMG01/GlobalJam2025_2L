extends Control


var cartel = false


func _ready():
	$pausa.visible = false



func _process(delta):
	if get_tree().paused == true and not cartel and GlovalVar.victoria == true:
			$pausa.visible = true
			$AudioStreamPlayer2D.play()
			cartel = true


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/Menu/menu.tscn")



func _on_sigiente_pressed() -> void:
	get_tree().paused = false
	if GlovalVar.nivelActual == 1:
		get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_2.tscn")
	if GlovalVar.nivelActual == 2:
		get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_3.tscn")
