extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const SUPER_JUMP_VELOCITY = -1400.0
var speed_modifier = 1.0
var double_jump_active = false
var super_jumping = false
var can_throw = true
var throwing = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const POTION = preload("res://scenes/potion.tscn")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if(!super_jumping):
			double_jump_active = false
			speed_modifier = 1
		else:
			super_jumping = false

	# Handle jump and double jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor(): #normal jump
			velocity.y = JUMP_VELOCITY
			double_jump_active = true
		elif double_jump_active: #double jump
			speed_modifier = 1
			velocity.y = JUMP_VELOCITY
			double_jump_active = false
	
	if Input.is_action_pressed("attack_down") and can_throw:
		#start cooldown
		can_throw = false
		%PotionCooldown.start()
		
		#Throw potion
		var new_potion = POTION.instantiate()
		new_potion.global_transform = %PotionDown.global_transform
		%PotionDown.add_child(new_potion)
	
	if Input.is_action_pressed("attack_right") and can_throw and is_on_floor():
		#start cooldown
		can_throw = false
		%PotionCooldown.start()
		
		#Throw potion
		throwing = true
		%Throwing.start()
		
		var new_potion = POTION.instantiate()
		new_potion.global_transform = %PotionRight.global_transform
		%PotionRight.add_child(new_potion)
	
	if Input.is_action_pressed("attack_left") and can_throw and is_on_floor():
		#start cooldown
		can_throw = false
		%PotionCooldown.start()
		
		#Throw potion
		throwing = true
		%Throwing.start()
		
		var new_potion = POTION.instantiate()
		new_potion.global_transform = %PotionLeft.global_transform
		%PotionLeft.add_child(new_potion)
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction and !throwing:
		velocity.x = direction * SPEED * speed_modifier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if %HurtBox.get_overlapping_bodies().size() > 0:
		death()
	
	move_and_slide()

func on_explosion():
	super_jumping = true
	speed_modifier = 0.5
	double_jump_active = true
	velocity.y = SUPER_JUMP_VELOCITY

func death():
	%Dead.visible = true


func _on_potion_cooldown_timeout():
	can_throw = true


func _on_throwing_timeout():
	throwing = false
