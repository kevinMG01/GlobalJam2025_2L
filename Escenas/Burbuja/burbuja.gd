extends CharacterBody2D


var roca = preload("res://Escenas/objetos/roca.tscn")
var madera
var piedra


var objetosDeProteccion = {
	"roca" : 0,
	"cichilloCoc": 0,
	"aguja": 0,
	"cuchillo": 0
}
var cantidadObjetos = objetosDeProteccion.roca
var habilidad = 0

var SPEED = 550
var habVeloc = 700

var habRecolectada = {
	'velocidad': false,
	'escudo': false
}


@onready var audio_player = $AudioStreamPlayer2D

func _ready():
	activarHabilidad()
	audio_player.connect("finished", muerte)

func muerte():
	GlovalVar.derota = true
	get_tree().paused = true
	self.queue_free()

func _physics_process(delta):
	$AnimatedSprite2D.rotation_degrees += 1
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

func activarHabilidad():
	if habRecolectada.escudo ==false:
		$escudo.position = Vector2(0, 200)
	if habRecolectada.escudo == true:
		$escudo.position = Vector2(0,0)

	if habRecolectada.velocidad ==false:
		SPEED = 550
	elif habRecolectada.velocidad ==true:
		SPEED = habilidad

func recolectarProtector(item : String):
	if item == "roca":
		objetosDeProteccion.roca += 1
	if item == "cuchilloCoc":
		objetosDeProteccion.cuchilloCoc += 1
	if item == "aguja":
		objetosDeProteccion.aguja += 1
	if item == "cuchillo":
		objetosDeProteccion.cuchillo += 1

func spawnDefenza():
	if cantidadObjetos >=3:
		pass

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




	
