extends RigidBody2D

const FLIGHT_SPEED = 1000
const EXPLOSION = preload("res://scenes/explosion_damage.tscn")
var explode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var direction = Vector2.RIGHT.rotated(rotation)
	set_axis_velocity(direction * FLIGHT_SPEED)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if %HitBox.get_overlapping_bodies().size() > 0 and !explode:
		freeze = true
		explode = true
		
		var new_explosion = EXPLOSION.instantiate()
		new_explosion.global_position = global_position
		add_child(new_explosion)
		
		%Puteli.visible = false
		%Timer.start()


func _on_timer_timeout():
	queue_free()
