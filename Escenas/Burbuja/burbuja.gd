extends CharacterBody2D


var roca = preload("res://Escenas/objetos/roca.tscn")
var madera
var piedra


var objetosDeProteccion = {
	"roca" : 0,
	"madera": 0,
	"piedra": 0
}
var cantidadObjetos = objetosDeProteccion.roca + objetosDeProteccion.madera + objetosDeProteccion.piedra
var habilidad = 0

var SPEED = 550
var habVeloc = 700


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
		self.queue_free()

	if body.is_in_group("velocidad"):
		SPEED = habilidad
		body.queue_free()

	if body.is_in_group("escudo"):
		
		body.queue_free()


func _on_cont_habi_timeout():
	GlovalVar.grupo = "enemigo"
	$ContHabi.stop()

