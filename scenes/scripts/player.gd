extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const SUPER_JUMP_VELOCITY = -1200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var double_jump_active = false

var camera_action = 0
var camera_pos_x = 0
const CAMERA_SPEED = 1500
const CAMERA_MAX_X_PX = 50


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump and double jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor(): #normal jump
			velocity.y = JUMP_VELOCITY
			double_jump_active = true
		elif double_jump_active: #double jump
			velocity.y = JUMP_VELOCITY
			double_jump_active = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction > 0 and is_on_floor():
			camera_action = 0
		elif direction < 0 and is_on_floor():
			camera_action = 1
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	match camera_action:
		0:
			if camera_pos_x < CAMERA_MAX_X_PX:
				camera_pos_x += CAMERA_SPEED * delta
		1:
			if camera_pos_x > -CAMERA_MAX_X_PX:
				camera_pos_x -= CAMERA_SPEED * delta
	
	%PlayerCamera.offset.x = camera_pos_x
	
	move_and_slide()
