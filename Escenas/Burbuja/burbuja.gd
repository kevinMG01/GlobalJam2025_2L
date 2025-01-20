extends CharacterBody2D


var roca
var madera
var piedra


var objetosDeProteccion = {
	"roca" : 0,
	"madera": 0,
	"piedra": 0
}

var habilidad = 0

const SPEED = 550



func _physics_process(delta):
	if habilidad > 0 :
		if Input.is_action_just_pressed("ui_accept"):
			GlovalVar.grupo = "objetos"
			$ContHabi.wait_time = 4
			$ContHabi.start(4)
			habilidad -= 1

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func recolectarProtector(item : String):
	if item == "roca":
		objetosDeProteccion.roca += 1

var objetosInstanciados = 0

func _ready():
	# Instanciar aleatoriamente 3 objetos de protección cuando inicia el juego
	while objetosInstanciados < 3:
		var objetoAleatorio = obtener_objeto_aleatorio()
		if objetoAleatorio:
			var instancia = objetoAleatorio.instance()
			# Ajustar posición aleatoria dentro de la escena
			instancia.position = Vector2(randf_range(100, 800), randf_range(100, 600))
			add_child(instancia)
			objetosInstanciados += 1

func obtener_objeto_aleatorio() -> PackedScene:
	# Lista de objetos disponibles
	var objetosDisponibles = []
	
	if objetosDeProteccion["roca"] == 0:
		objetosDisponibles.append(roca)
	if objetosDeProteccion["madera"] == 0:
		objetosDisponibles.append(madera)
	if objetosDeProteccion["piedra"] == 0:
		objetosDisponibles.append(piedra)
	
	# Elegir aleatoriamente un objeto de los disponibles
	if objetosDisponibles.size() > 0:
		return objetosDisponibles[randi() % objetosDisponibles.size()]
	
	return null


func _on_detector_body_entered(body):
	# obtener habilidad
	if body.is_in_group("habilidad"):
		habilidad += 1

	#recolectar protecciones
	if body.is_in_group("objetos"):
		recolectarProtector(body.item)
		body.queue_free()

	# derota
	if body.is_in_group("enemigo"):
		self.queue_free()


func _on_cont_habi_timeout():
	GlovalVar.grupo = "enemigo"
	$ContHabi.stop()

