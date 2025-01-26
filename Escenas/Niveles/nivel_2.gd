extends Node2D


var roca = preload("res://Escenas/objetos/roca.tscn")
var cuchilloCoc = preload("res://Escenas/objetos/cuchillo_coc.tscn")
var agujas = preload("res://Escenas/objetos/agujas.tscn")
var cuchillo = preload("res://Escenas/objetos/cuchillo.tscn")
var player = preload("res://Escenas/Burbuja/burbuja.tscn")

@onready var marker1 = $instanObj/Izq
@onready var marker2 = $instanObj/Der

var cantidadObjetos = 2

var tiempo = 50

@onready var telonOscuro = $telonOscuro
var opacity = 1.0
var fade_speed = 0.3  # Velocidad de la disminución de opacidad

func _ready():
	$AudioStreamPlayer2D.play()
	GlovalVar.victoria = false
	GlovalVar.spawnPlayer = false
	GlovalVar.derota = false
	GlovalVar.nivelActual = 2
	randomize()
	$tiempoSpawn.wait_time = 2
	$tiempoSpawn.start()
	$temporizador.wait_time =tiempo
	$temporizador.start()


func _physics_process(delta):
	if opacity > 0:
		opacity -= fade_speed * delta  # Decrece la opacidad según el tiempo
		telonOscuro.modulate.a = opacity
	if GlovalVar.spawnPlayer == true:
		spawnPlayer()
	$textTiempo.text = "Tiempo: " + str(int($temporizador.time_left))
	pass


func spawn(obj):
	for i in range(cantidadObjetos):
		# Instanciamos el objeto roca
		var objeto = obj.instantiate()
		objeto. gravity = 350
		# Calculamos una posición aleatoria en el eje X entre Marker2D y Marker2D2
		var x_pos = randf_range(marker1.position.x, marker2.position.x)

		objeto.position = Vector2(x_pos, marker1.position.y)  # Asumimos que se deben alinear en Y

		$instanObj.add_child(objeto)

func spawnPlayer():
	var newPlayer = player.instantiate()
	newPlayer.global_position = $Marker2D.global_position
	newPlayer.colicionVisible()
	get_parent().add_child(newPlayer)
	
	GlovalVar.spawnPlayer = false

func _on_tiempo_spawn_timeout() -> void:
	var newspawn = randi_range(1,4)
	if newspawn == 1:
		spawn(roca)
	if newspawn == 2:
		spawn(cuchilloCoc)
	if newspawn == 3:
		spawn(agujas)
	if newspawn == 4:
		spawn(cuchillo)
	var num = randi_range(1,2)
	cantidadObjetos = num
	var tim = randf_range(0.3, 1.1)
	$tiempoSpawn.wait_time = tim


func _on_viento_timeout() -> void:
	GlovalVar.viento = true
	var v = randi_range(1, 3)
	if v == 1:
		GlovalVar.vientoIzqDer = true
	elif v == 2:
		GlovalVar.vientoIzqDer = false
			
	$detenerViento.wait_time = 3
	$detenerViento.start()


func _on_detener_viento_timeout() -> void:
	GlovalVar.viento = false
	$detenerViento.stop()


func _on_temporizador_timeout() -> void:
	get_tree().paused = true
	GlovalVar.victoria = true
