extends CharacterBody2D


var item = "cuchilloCoc"
var viento = true

#const SPEED = 200.0
var gravity = 500



func _ready():
	grupos()



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta 

	rotation_degrees += 1
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * SPEED
	if viento == true:
		if GlovalVar.viento == true:
			if GlovalVar.vientoIzqDer == true:
				velocity.x += 4
			if GlovalVar.vientoIzqDer == false:
				velocity.x -= 4

	move_and_slide()

func removerGrupo():
	remove_from_group("enemigo")
	remove_from_group("objetos")

func asignarGrupo(grup: String):
	add_to_group(grup)

var grupo_anterior: String = ""  # Variable para almacenar el valor anterior

func _process(delta):
	if GlovalVar.grupo != grupo_anterior:  # Compara el valor actual con el anterior
		grupos()
		grupo_anterior = GlovalVar.grupo  # Actualiza el valor anterior para la próxima comparación
	
func grupos():
	if GlovalVar.grupo == "enemigo":
		removerGrupo()
		asignarGrupo("enemigo")
	if GlovalVar.grupo == "objetos":
		removerGrupo()
		asignarGrupo("objetos")
	
