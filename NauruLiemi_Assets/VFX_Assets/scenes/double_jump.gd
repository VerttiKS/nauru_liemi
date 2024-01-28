extends Node2D

func _ready():
	$CloudParticles.emitting = true
	$StarParticles.emitting = true



func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
