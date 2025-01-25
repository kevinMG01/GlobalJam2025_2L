extends Node2D



var roca = preload("res://Escenas/objetos/roca.tscn")
var cuchilloCoc = preload("res://Escenas/objetos/cuchillo_coc.tscn")
var agujas = preload("res://Escenas/objetos/agujas.tscn")
var cuchillo = preload("res://Escenas/objetos/cuchillo.tscn")

@onready var marker1 = $instanObj/Izq
@onready var marker2 = $instanObj/Der

var cantidadObjetos = 2

var tiempo = 76


func _ready():
	GlovalVar.victoria = false
	GlovalVar.nivelActual = 5
	randomize()
	$tiempoSpawn.wait_time = 2
	$tiempoSpawn.start()
	$temporizador.wait_time =tiempo
	$temporizador.start()


func _physics_process(delta):

	$textTiempo.text = "Tiempo: " + str(int($temporizador.time_left))
	pass


func spawn(obj):
	for i in range(cantidadObjetos):
		# Instanciamos el objeto roca
		var objeto = obj.instantiate()
		
		# Calculamos una posición aleatoria en el eje X entre Marker2D y Marker2D2
		var x_pos = randf_range(marker1.position.x, marker2.position.x)
		objeto. gravity = 750
		
		objeto.position = Vector2(x_pos, marker1.position.y)  # Asumimos que se deben alinear en Y
		
		$instanObj.add_child(objeto)

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
	var num = randi_range(2,5)
	cantidadObjetos = num
	var tim = randf_range(0.3, 1.0)
	$tiempoSpawn.wait_time = tim
	#n2: 1-4 . t: 1.2 . 


func _on_viento_timeout() -> void:
	GlovalVar.viento = true
	var v = randi_range(1, 4)
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
