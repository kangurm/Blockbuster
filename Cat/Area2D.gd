extends Area2D

@onready var root = (get_node("../../"))
@onready var player = (root.get_node("player")).get_node("CollisionShape2D2")
@onready var area_position = self

func _process(delta):
	#if globals.catReached == true:
		#print("CAT REACHED")
	# Check if the player is within the bounds of the Area2D
	if is_player_inside():
		globals.catReached = true
		self.queue_free()


# Check if the player is inside the Cat Area2D
func is_player_inside() -> bool:
	var player_position = player.global_position
	var area_position = global_position
	var area_size = get_area_size()
	return ((player_position.x > area_position.x - area_size.x / 2 and
			player_position.x < area_position.x + area_size.x / 2) and
			(player_position.y > area_position.y - area_size.y / 2 and
			player_position.y < area_position.y + area_size.y / 2))

func get_area_size() -> Vector2:
	var max_size = Vector2.ZERO
	for child in get_children():
		if child is CollisionShape2D:
			var shape = child.shape
			if shape is RectangleShape2D:
				var extents = shape.extents
				max_size.x = max(max_size.x, extents.x * 2)
				max_size.y = max(max_size.y, extents.y * 2)
	return max_size
