extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const SUPER_JUMP_VELOCITY = -1400.0
var speed_modifier = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var double_jump_active = false



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		double_jump_active = false
		speed_modifier = 1

	# Handle jump and double jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor(): #normal jump
			velocity.y = JUMP_VELOCITY
			double_jump_active = true
		elif double_jump_active: #double jump
			speed_modifier = 1
			velocity.y = JUMP_VELOCITY
			double_jump_active = false
			
	if Input.is_action_just_pressed("attack_down"):
		if is_on_floor():
			speed_modifier = 0.5
			double_jump_active = true
			velocity.y = SUPER_JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * speed_modifier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if %HurtBox.get_overlapping_bodies().size() > 0:
		death()
	
	move_and_slide()

func death():
	%Dead.visible = true
