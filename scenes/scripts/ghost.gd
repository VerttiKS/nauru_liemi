extends CharacterBody2D

const SPEED = 200.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dying = false
var direction = 1


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and !dying:
		velocity.y += gravity * delta
		
	%RayCast2D.force_raycast_update()
	if is_on_wall() or !%RayCast2D.is_colliding():
		direction *= -1
	
	if !dying:
		%RayCast2D.position.x = direction * 50
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		velocity.y = -1 * SPEED
	
	move_and_slide()
	
func on_explosion():
	dying = true
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	%CollisionShape2D.set_deferred("disabled", true)
	%DeathTimer.start()


func _on_death_timer_timeout():
	queue_free()
