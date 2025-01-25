extends Control



var visibleCartel = false
var add = 1


func _ready():
	if GlovalVar.reintentar == 4:
		GlovalVar.reintentar = 1
	posReintentar()
	if GlovalVar.derota == false:
		$der.visible = false


func _process(delta):
	if add >= 2:
		$der/Panel/Reintentar/Text.text ="Reintentar"
	if GlovalVar.derota == true and not visibleCartel:
		$der.visible = true
		$Timer.wait_time = 0.5
		$Timer.start()
		visibleCartel = true


func posReintentar():
	if GlovalVar.reintentar == 1:
		$der/Panel/Reintentar. position = Vector2(0,284)
	elif GlovalVar.reintentar == 2:
		$der/Panel/Reintentar. position = Vector2(0,1300)

func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
	$Timer.stop()


func _on_reintentar_pressed() -> void:
	if add >=2:
		get_tree().paused = false
		$der.visible = false
		visibleCartel = false
		return
	$der/add.visible = true
	add += 1
	


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/Menu/menu.tscn")


func _on_add_pressed() -> void:
	$der/add.visible = false
	pass # Replace with function body.


func _on_button_button_down() -> void:
	OS.shell_open("https://drive.google.com/drive/u/0/folders/1j8spdrtPs864ualPiX0MgKuW_2TK_KHU")
	pass # Replace with function body.
