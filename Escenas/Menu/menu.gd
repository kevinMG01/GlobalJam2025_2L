extends Control

var burbujaVioleta = preload("res://Escenas/burbujaMenu/animated_sprite_2d.tscn")
var burbujaRosa = preload("res://Escenas/burbujaMenu/burbuja_rosa.tscn")
var burbujaVerde = preload("res://Escenas/burbujaMenu/burbuja_verde.tscn")
var burbujaVerdoso = preload("res://Escenas/burbujaMenu/burbuja_verdoso.tscn")

var cantidadObjetos = 3
@onready var marker1 = $Marker2D
@onready var marker2 = $Marker2D2



func _on_play_button_down():
	$play.play()
	$timPlay.start()






func _on_tim_play_timeout():
	get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_1.tscn")



func _on_creditos_button_down():
	$play.play()

#Funciones Del Menu :
 #Jugar
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_1.tscn")

#Creditos
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Creditos/Creditos.tscn")

#Salir
func _on_button_3_pressed() -> void:
	get_tree().quit()




func spawn(obj):
	for i in range(cantidadObjetos):

		var objeto = obj.instantiate()
		objeto.tiempo = randi_range(1,8)
		var newScala = randf_range(0.06, 0.21)
		objeto.escala = Vector2(newScala,newScala)
		var x_pos = randf_range(marker1.position.x, marker2.position.x)

		objeto.position = Vector2(x_pos, marker1.position.y)  # Asumimos que se deben alinear en Y

		get_parent().add_child(objeto)



func _on_burbijitas_timeout() -> void:
	var newObjeto = randi_range(1,4)
	if newObjeto == 1:
		spawn(burbujaVioleta)
	elif newObjeto == 2:
		spawn(burbujaRosa)
	elif newObjeto == 3:
		spawn(burbujaVerde)
	elif newObjeto == 4:
		spawn(burbujaVerdoso)
