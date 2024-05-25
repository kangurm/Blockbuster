extends Node2D

func _input (event):
	if Input.is_action_just_pressed("mb_left"):
		self.get_node("Timer")
