extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/e_1m_1.tscn") #Pressing space let's you skip the comic

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/e_1m_1.tscn")
