extends Node2D

func _input (event):
	if Input.is_action_just_pressed("mb_left"):
		self.get_node("Timer")


func _on_clicked():
	if Input.is_action_just_pressed("mb_left"):
		var timer = self.get_node("Timer")
		print("On clicked fired")
		timer.activate_timer();
