extends AnimatedSprite2D

var velocidad = 2
var tiempo = 3
var escala

func _ready() -> void:
	$Timer.wait_time = tiempo
	$Timer.start()
	scale = escala



func _process(delta: float) -> void:
	position.y -= velocidad
	pass


func _on_timer_timeout() -> void:
	animation = "explocion"
	$Timer2.start()
	pass



func _on_timer_2_timeout() -> void:
	queue_free()
