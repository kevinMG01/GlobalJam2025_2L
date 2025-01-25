extends CharacterBody2D


var roca = preload("res://Escenas/objetos/roca.tscn")
var aguja = preload("res://Escenas/objetos/agujas.tscn")
var cuchillo_coc = preload("res://Escenas/objetos/cuchillo_coc.tscn")
var cuchillo = preload("res://Escenas/objetos/cuchillo.tscn")
var x = true

var objetosDeProteccion = {
	"roca" : 0,
	"cichilloCoc": 0,
	"aguja": 0,
	"cuchillo": 0
}
var cantidadObjetos = objetosDeProteccion.roca
var habilidad = 0

var SPEED = 550
var habVeloc = 820

var habRecolectada = {
	'velocidad': false,
	'escudo': false
}


@onready var audio_player = $AudioStreamPlayer2D

var puntosDeInstanciacion = [
	Vector2(-126, -114),  # Primer punto
	Vector2(-2, -146),  # Segundo punto
	Vector2(116, -107)   # Tercer punto
]

func _ready():
	activarHabilidad()
	audio_player.connect("finished", muerte)

func muerte():
	GlovalVar.derota = true
	get_tree().paused = true
	self.queue_free()

func _physics_process(delta):
	$AnimatedSprite2D.rotation_degrees += 1
	#--------------------
	if obtenerCantidadObjetos() >= 3 and Input.is_action_just_pressed("ui_up"):  # "ui_accept" es la tecla "Enter", pero puedes cambiarla a "f" si lo deseas
		instanciarObjetos()
	
	if $escudo2.visible == true:
		for i in 1:
			$animacioEscudo.start()

	if habilidad > 0 :
		if Input.is_action_just_pressed("ui_accept"):
			GlovalVar.grupo = "objetos"
			$ContHabi.wait_time = 4
			$ContHabi.start(4)
			habilidad -= 1

	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")

	# Movimiento en el eje X
	if direction_x:
		velocity.x = direction_x * SPEED
		#if direction_x == 1:
			#$NuevoLienzo.flip_h = true
		#elif direction_x == -1:
			#$NuevoLienzo.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Movimiento en el eje Y
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()


func recolectarProtector(item : String):
	if item in objetosDeProteccion:
		objetosDeProteccion[item] += 1

func instanciarObjetos():
	var objetosDisponibles = []

	# Crear lista de objetos disponibles (solo aquellos con cantidad > 0)
	for objeto in objetosDeProteccion.keys():
		if objetosDeProteccion[objeto] > 0:
			objetosDisponibles.append(objeto)

	# Instanciar los objetos seleccionados en los puntos fijos
	var objetosSeleccionados = []
	var puntosInstanciados = 0

	# Mientras tengamos puntos disponibles y objetos para instanciar
	for objeto in objetosDisponibles:
		while objetosDeProteccion[objeto] > 0 and puntosInstanciados < 3:
			var objetoInstanciado = cargarObjeto(objeto)
			if objetoInstanciado:
				# Instanciamos el objeto en el siguiente punto disponible
				var instancia = objetoInstanciado.instantiate()
				instancia.usoDePlayer = true
				add_child(instancia)
				instancia.position = puntosDeInstanciacion[puntosInstanciados]

				# Aumentamos el contador de puntos instanciados
				puntosInstanciados += 1
				restarObjeto(objeto)  # Restamos el objeto instanciado
			if puntosInstanciados >= 3:
				break

	# Si hemos instanciado 3 objetos, terminamos el proceso
	if puntosInstanciados < 3:
		print("No se pudieron instanciar 3 objetos debido a la cantidad disponible.")


func cargarObjeto(nombre: String) -> PackedScene:
	if nombre == "roca":
		return roca
	elif nombre == "cuchilloCoc":
		return cuchillo_coc
	elif nombre == "aguja":
		return aguja
	elif nombre == "cuchillo":
		return cuchillo
	return null

# Función para restar 1 de la lista de objetosDeProteccion
func restarObjeto(nombre: String):
	if nombre in objetosDeProteccion and objetosDeProteccion[nombre] > 0:
		objetosDeProteccion[nombre] -= 1

# Función que devuelve la cantidad total de objetos disponibles
func obtenerCantidadObjetos() -> int:
	var total = 0
	for cantidad in objetosDeProteccion.values():
		total += cantidad
	return total
#error ; function " cantidadObjetos" has the same name as a previously declared variable
func activarHabilidad():
	if habRecolectada.escudo ==false:
		$escudo.position = Vector2(0, 200)
	if habRecolectada.escudo == true:
		$escudo.position = Vector2(0,0)

	if habRecolectada.velocidad ==false:
		SPEED = 550
	elif habRecolectada.velocidad ==true:
		SPEED =habVeloc


func spawnDefenza():
	if cantidadObjetos >=3:
		pass


func colicionVisible():
	if x == false:
		$CollisionShape2D.disabled = true
		$detector.disconnect("body_entered", _on_detector_body_entered)# error
		$muerte.wait_time = 9
		$muerte.start()
	elif x == true:
		$CollisionShape2D.disabled = false
		


func _on_detector_body_entered(body):
	# obtener habilidad
	if body.is_in_group("habilidad"):
		habilidad += 1
		body.queue_free()

	#recolectar protecciones
	if body.is_in_group("objetos"):
		recolectarProtector(body.item)
		body.queue_free()

	# derota
	if body.is_in_group("enemigo"):
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("explocion")
		$AnimatedSprite2D.animation = "explocion"
		#GlovalVar.derota = true
		#get_tree().paused = true
		#self.queue_free()

	if body.is_in_group("velocidad"):
		habRecolectada.velocidad = true
		body.queue_free()
		activarHabilidad()

	if body.is_in_group("escudo"):
		habRecolectada.escudo = true
		$escudo2.visible = true
		body.queue_free()
		activarHabilidad()


func _on_cont_habi_timeout():
	GlovalVar.grupo = "enemigo"
	$ContHabi.stop()



func _on_escudo_body_entered(body):
	if body.is_in_group("enemigo"):
		habRecolectada.escudo = false
		$escudo2.visible = false
		$animacioEscudo.stop()
		activarHabilidad()
		body.queue_free()


var ani = false
func _on_animacio_escudo_timeout():
	var newani = !ani
	if ani == false:
		$escudo2.scale = Vector2(1.2, 1.2)
	if ani == true:
		$escudo2.scale = Vector2(0.2, 1)


func _on_muerte_timeout() -> void:
	colicionVisible()
	$muerte.stop()
	pass
