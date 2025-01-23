extends Control



var visibleCartel = false

func _ready():
	if GlovalVar.derota == false:
		$der.visible = false


func _process(delta):
	if GlovalVar.derota == true and not visibleCartel:
		$der.visible = true
		$Timer.wait_time = 0.5
		$Timer.start()
		visibleCartel = true




func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
	$Timer.stop()
