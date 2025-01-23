extends Control





#func _ready():
	#if GlovalVar.derota == false:
		#$der.visible = false


func _process(delta):
	if GlovalVar.derota == true:

			$der.visible = true
			$Timer.start()




func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
	$Timer.stop()
