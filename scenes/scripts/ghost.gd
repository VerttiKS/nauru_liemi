extends CharacterBody2D

const SPEED = 200.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		direction *= -1
	
	velocity.x = direction * SPEED
	
	move_and_slide()
