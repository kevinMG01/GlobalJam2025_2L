extends CharacterBody2D


const SPEED = 300.0


var gravity = 100


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
