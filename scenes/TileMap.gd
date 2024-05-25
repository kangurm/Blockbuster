extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input (event):
	if Input.is_action_just_pressed("mb_left"):
		var mouse_position = get_global_mouse_position()
		var tile_mouse_pos = local_to_map(mouse_position)
		#var tile_info = get_cell_source_id(0, tile_mouse_pos) not needed if only 1 atlas
		var tile_atlas_coord = get_cell_atlas_coords(0, tile_mouse_pos)
		#print(tile_info)
		print(tile_atlas_coord)
		set_cell(0, tile_mouse_pos, -1)
		
		
		
	if Input.is_action_just_pressed("mb_right"):
			var mouse_position = get_global_mouse_position()
			print(mouse_position)
			
			var tile_mouse_pos = local_to_map(mouse_position)
			print(tile_mouse_pos)
			
			var source_id = 0
			var atlas_coord = Vector2i(1,0)
			set_cell(0,tile_mouse_pos, source_id, atlas_coord)
		

