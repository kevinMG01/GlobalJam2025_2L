extends Node2D


var roca = preload("res://Escenas/objetos/roca.tscn")
var cuchilloCoc = preload("res://Escenas/objetos/cuchillo_coc.tscn")
var agujas = preload("res://Escenas/objetos/agujas.tscn")
var cuchillo = preload("res://Escenas/objetos/cuchillo.tscn")

@onready var marker1 = $instanObj/Izq
@onready var marker2 = $instanObj/Der

var cantidadObjetos = 2

var tiempo = 45


func _ready():
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

		objeto.position = Vector2(x_pos, marker1.position.y)  # Asumimos que se deben alinear en Y

		$instanObj.add_child(objeto)


func _on_tiempo_spawn_timeout():
	var newspawn = randi_range(1,4)
	if newspawn == 1:
		spawn(roca)
	if newspawn == 2:
		spawn(cuchilloCoc)
	if newspawn == 3:
		spawn(agujas)
	if newspawn == 4:
		spawn(cuchillo)
	var num = randi_range(0,2)
	cantidadObjetos = num
	var tim = randf_range(0.5, 1.3)
	$tiempoSpawn.wait_time = tim
	


func _on_viento_timeout():
	GlovalVar.viento = true
	var v = randi_range(1, 3)
	if v == 1:
		GlovalVar.vientoIzqDer = true
	elif v == 2:
		GlovalVar.vientoIzqDer = false
			
	$detenerViento.wait_time = 3
	$detenerViento.start()


func _on_detener_viento_timeout():
	GlovalVar.viento = false
	$detenerViento.stop()

func _on_temporizador_timeout():
	get_tree().paused = true

