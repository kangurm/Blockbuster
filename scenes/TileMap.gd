extends TileMap

signal tile_broken

var tier = 0
var reach = 15
var current_tile_pos: Vector2i

func break_block(event, tile_atlas_coord, tile_mouse_pos):
	var coordX = tile_atlas_coord.x
	var coordY = tile_atlas_coord.y
	var damage = tier - coordY +1
	
	if tier >=coordY:
		if coordX + damage < 5 && coordX > -1:
			set_cell(0, tile_mouse_pos,1, Vector2i(coordX+damage, coordY))
		else:
			if coordY == 4:
				globals.block_inv['dirt'] += 1
			if coordY == 3:
				globals.block_inv['stone'] += 1
			if coordY == 2 :
				globals.block_inv['granite'] +=1
			if coordY == 1:
				globals.block_inv['obsidian'] +=1
			if coordY == 0:
				globals.block_inv['oil_shale'] +=1
			set_cell(0, tile_mouse_pos, -1)
			emit_signal('tile_broken')




func mine(event) :
	await get_tree().create_timer(0.1).timeout
	var mouse_position = get_global_mouse_position()
	var screen_size = get_viewport_rect().size
	var center = Vector2(screen_size.x/2, screen_size.y/2)
	var mouse_pos = get_viewport().get_mouse_position()
	var rel_position = mouse_pos-center
	var distance = local_to_map(rel_position)
	var tile_mouse_pos = local_to_map(mouse_position)
	var tile_atlas_coord = get_cell_atlas_coords(0, tile_mouse_pos)
	if tier == 0:
		if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, tile_mouse_pos) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, tile_mouse_pos) != 0 :
			break_block(event, tile_atlas_coord, tile_mouse_pos)
	if tier == 1:
		for i in 3:
			for j in 3:
				var coord =  Vector2i (tile_mouse_pos.x-1+i, tile_mouse_pos.y-1+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0 :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if tier == 2:
		for i in 5:
			for j in 5:
				var coord =  Vector2i (tile_mouse_pos.x-2+i, tile_mouse_pos.y-2+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0  :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if tier == 3:
		for i in 9:
			for j in 9:
				var coord =  Vector2i (tile_mouse_pos.x-4+i, tile_mouse_pos.y-4+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0  :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if tier == 4:
		for i in 15:
			for j in 15:
				var coord =  Vector2i (tile_mouse_pos.x-7+i, tile_mouse_pos.y-7+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0 :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)

func _input (event):
	
	if Input.is_action_just_pressed("pressI"):
		if tier < 4:
			tier += 1
			print('breaker tier:', tier)
	if Input.is_action_just_pressed("pressJ"):
		if tier >0:
			tier -=1
			print('breaker tier:', tier)
	if Input.is_action_just_pressed("mb_left"):
		while true:
			if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
				await mine(event)
			else:
				break

	# place blocks
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			var mouse_position = get_global_mouse_position()
			var tile_mouse_pos = local_to_map(mouse_position)
			var source_id = 1
			var atlas_coord = Vector2i(0,0)
			
			set_cell(0,tile_mouse_pos, source_id, atlas_coord)
