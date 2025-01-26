extends Control



var visibleCartel = false
var add = 1
var ocultarReintentar = false

func _ready():
	if GlovalVar.reintentar == 4:
		GlovalVar.reintentar = 1
	posReintentar()
	$der.visible = false
	if GlovalVar.derota == false:
		$der.visible = false
	$publicidad.start(8)
	$der/add/add.visible = false
	$der/add/Label.visible = true




func _process(delta):
	if add >= 2:
		$der/Panel/Reintentar/Text.text ="Reintentar"
	if GlovalVar.derota == true and not visibleCartel:
		if ocultarReintentar == true:
			$der/Panel/Reintentar.visible = false
		$der.visible = true
		$Timer.wait_time = 0.5
		$Timer.start()
		visibleCartel = true
	$der/add/Label.text = "Saltar " + str(int($publicidad.time_left))


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
	GlovalVar.spawnPlayer = true
	


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/Menu/menu.tscn")


func _on_add_pressed() -> void:
	$der/add.visible = false
	ocultarReintentar = true
	pass # Replace with function body.


func _on_button_button_down() -> void:
	OS.shell_open("https://x.com/TachuelaArt?t=0Huw-wuLeXIOaubtb4KyZg&s=08")
	pass # Replace with function body.


func _on_publicidad_timeout() -> void:
	$der/add/add.visible = true
	$der/add/Label.visible = false
	$publicidad.stop()
