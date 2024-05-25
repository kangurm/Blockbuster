extends TileMap

signal tile_broken

var block_inv = {
	"dirt": 0,
	"stone": 0,
	"granite": 0,
	"obsidian": 0,
	"oil_shale": 0,
}

var tier = 4
var reach = 15
var current_tile_pos: Vector2i

func break_block(event, tile_atlas_coord, tile_mouse_pos):
	
	
	set_cell(0, tile_mouse_pos, -1)
	if tile_atlas_coord == 0:
		block_inv['stone'] += 1
	if tile_atlas_coord == 1:
		print('nothing yet')
	if tile_atlas_coord == 2 :
		block_inv['dirt'] +=1
	if tile_atlas_coord == 3:
		block_inv['granite'] +=1
	if tile_atlas_coord == 4:
		block_inv['obsidian'] +=1
	if tile_atlas_coord == 5:
		block_inv['oil_shale'] += 1
	
	
	

func mine(event) :
	await get_tree().create_timer(0.1).timeout
	var mouse_position = get_global_mouse_position()
	var screen_size = get_viewport_rect().size
	var center = Vector2(screen_size.x/2, screen_size.y/2)
	var mouse_pos = get_viewport().get_mouse_position()
	var rel_position = mouse_pos-center
	var distance = local_to_map(rel_position)
	var tile_mouse_pos = local_to_map(mouse_position)
	var tile_atlas_coord = get_cell_atlas_coords(0, tile_mouse_pos).y
	#print(tier)
	if tier == 0:
		if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, tile_mouse_pos) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach :
			break_block(event, tile_atlas_coord, tile_mouse_pos)
	if tier == 1:
		for i in 3:
			for j in 3:
				var coord =  Vector2i (tile_mouse_pos.x-1+i, tile_mouse_pos.y-1+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach :
					tile_atlas_coord = get_cell_atlas_coords(0,coord).y
					break_block(event, tile_atlas_coord, coord)
	if tier == 2:
		for i in 5:
			for j in 5:
				var coord =  Vector2i (tile_mouse_pos.x-2+i, tile_mouse_pos.y-2+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach :
					tile_atlas_coord = get_cell_atlas_coords(0,coord).y
					break_block(event, tile_atlas_coord, coord)
	if tier == 3:
		for i in 9:
			for j in 9:
				var coord =  Vector2i (tile_mouse_pos.x-4+i, tile_mouse_pos.y-4+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach :
					tile_atlas_coord = get_cell_atlas_coords(0,coord).y
					break_block(event, tile_atlas_coord, coord)
	if tier == 4:
		for i in 15:
			for j in 15:
				var coord =  Vector2i (tile_mouse_pos.x-7+i, tile_mouse_pos.y-7+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach :
					tile_atlas_coord = get_cell_atlas_coords(0,coord).y
					break_block(event, tile_atlas_coord, coord)
	print(block_inv)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input (event):
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
			var source_id = 0
			var atlas_coord = Vector2i(1,0)
			
			set_cell(0,tile_mouse_pos, source_id, atlas_coord)
