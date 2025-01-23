extends Control


var cartel = false


func _ready():
	$pausa.visible = false



func _process(delta):
	if get_tree().paused == true and not cartel:
			$pausa.visible = true
			$AudioStreamPlayer2D.play()
			cartel = true
