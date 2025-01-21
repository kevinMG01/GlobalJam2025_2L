extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$pausa.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().paused == true:
		for i in 1:
			$pausa.visible = true
			$AudioStreamPlayer2D.play()
