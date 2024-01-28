extends Area2D

var times = 0

func _on_body_entered(body):
	if body.has_method("on_explosion"):
		body.on_explosion()


func _on_timer_timeout():
	%ExplosionArea.disabled = true
	
	times += 1
	if(times >= 4):
		queue_free()
