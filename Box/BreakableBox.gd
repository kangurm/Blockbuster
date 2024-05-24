extends Node2D

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#var child = get_node("Sprite2D")
		#print(child.get_rect(),get_global_mouse_position() )
		#if child.get_rect().has_point(get_global_mouse_position()):
			#print("You clicked on Sprite!")


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var sprite = get_node("Sprite2D")
		var sprite_rect = sprite.get_rect()
		var local_mouse_pos = sprite.to_local(get_global_mouse_position())
		print(sprite_rect, local_mouse_pos)
		if sprite_rect.has_point(local_mouse_pos):
			self.queue_free()
