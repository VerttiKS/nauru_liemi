extends Node2D

var death = false
var win = false
var time = 0

func _on_player_main_death():
	death = true
	%WaitTime.start()


func _on_player_victory():
	win = true
	%WaitTime.start()


func _on_wait_time_timeout():
	time += 1
	
	if time == 2:
		%GameOver.visible = true
		if death:
			%DeathWrite. visible = true
		if win:
			%LifeWrite.visible = true
	
	if time == 5:
		if death:
			get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
		if win:
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
