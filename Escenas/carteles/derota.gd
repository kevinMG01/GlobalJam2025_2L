extends Control



var visibleCartel = false

func _ready():
	if GlovalVar.reintentar == 4:
		GlovalVar.reintentar = 1
	posReintentar()
	if GlovalVar.derota == false:
		$der.visible = false


func _process(delta):
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
	get_tree().paused = false
	$der.visible = false
	visibleCartel = false

	


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/Menu/menu.tscn")
