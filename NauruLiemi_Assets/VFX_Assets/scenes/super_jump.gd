extends Node2D

func _ready():
	$GPUParticles2D.emitting = true



func _on_timer_timeout():
	queue_free()
