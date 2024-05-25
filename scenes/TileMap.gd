extends TileMap

signal tile_broken


var wait = 0.1
var reach = 15
var current_tile_pos: Vector2i

func break_block(event, tile_atlas_coord, tile_mouse_pos):
	
	var coordX = tile_atlas_coord.x
	var coordY = tile_atlas_coord.y
	var damage = globals.toolTier - coordY +1
	if globals.toolTier >=coordY:
		if coordX + damage < 5 && coordX > -1:
			set_cell(0, tile_mouse_pos,1, Vector2i(coordX+damage, coordY))
		else:
			var block_type
			# Air block
			if coordY == -1:
				return
			if coordY == 4:
				globals.block_inv['dirt'] += 1
				block_type = 'dirt'
			if coordY == 3:
				globals.block_inv['stone'] += 1
				block_type = 'stone'
			if coordY == 2 :
				globals.block_inv['granite'] +=1
				block_type = 'granite'
			if coordY == 1:
				globals.block_inv['obsidian'] +=1
				block_type = 'obsidian'
			if coordY == 0:
				globals.block_inv['oil_shale'] +=1
				block_type = 'oil_shale'
			set_cell(0, tile_mouse_pos, -1)
			emit_signal('tile_broken', block_type)

@onready var playerPos =  get_node('../../Node2D/player').global_position
func throw_object(event):
	var sprite = Sprite2D.new()
	sprite.texture = load('res://projectile/doll.png')
	playerPos =  get_node('../../Node2D/player').global_position
	sprite.scale = Vector2(0.02,0.02)
	sprite.position = playerPos
	sprite.look_at(get_global_mouse_position())
	sprite.rotate(-30)
	add_child(sprite)
	
	var tween = create_tween()
	tween.tween_property(sprite, 'position',get_global_mouse_position(), wait)
	await get_tree().create_timer(wait).timeout
	remove_child(sprite)
	


func mine(event):
	var mouse_position = get_global_mouse_position()
	var screen_size = get_viewport_rect().size
	var center = Vector2(screen_size.x/2, screen_size.y/2)
	var mouse_pos = get_viewport().get_mouse_position()
	var rel_position = mouse_pos - center
	var distance = local_to_map(rel_position)
	var tile_mouse_pos = local_to_map(mouse_position)
	var tile_atlas_coord = get_cell_atlas_coords(0, tile_mouse_pos)
	if distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && globals.toolTier > 0:
		throw_object(event)
	await get_tree().create_timer(wait).timeout
	
	
	if globals.toolTier == 0:
		if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, tile_mouse_pos) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, tile_mouse_pos) != 0 :
			break_block(event, tile_atlas_coord, tile_mouse_pos)
	if globals.toolTier == 1:
		for i in 3:
			for j in 3:
				var coord =  Vector2i (tile_mouse_pos.x-1+i, tile_mouse_pos.y-1+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0 :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if globals.toolTier == 2:
		for i in 5:
			for j in 5:
				var coord =  Vector2i (tile_mouse_pos.x-2+i, tile_mouse_pos.y-2+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0  :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if globals.toolTier == 3:
		for i in 9:
			for j in 9:
				var coord =  Vector2i (tile_mouse_pos.x-4+i, tile_mouse_pos.y-4+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0  :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if globals.toolTier == 4:
		for i in 15:
			for j in 15:
				var coord =  Vector2i (tile_mouse_pos.x-7+i, tile_mouse_pos.y-7+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <reach && distance.x > -reach && distance.y < reach && distance.y > -reach && get_cell_source_id(0, coord) != 0 :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)

var dont_place = [  Vector2i(1, -2), Vector2i(1, -1), Vector2i(1, 0), Vector2i(0, -2), Vector2i(0, -1), Vector2i(0, 0),  Vector2i(-1, -2), Vector2i(-1, -1), Vector2i(-1, 0)]

func _input (event):
	
	if Input.is_action_just_pressed("pressI"):
		if globals.toolTier < 4:
			globals.toolTier += 1
			wait += 0.1
			print('breaker globals.toolTier:', globals.toolTier)
	if Input.is_action_just_pressed("pressJ"):
		if globals.toolTier >0:
			globals.toolTier -=1
			wait -= 0.1
			print('breaker globals.toolTier', globals.toolTier)
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
		
		var screen_size = get_viewport_rect().size
		var center = Vector2(screen_size.x/2, screen_size.y/2)
		var mouse_pos = get_viewport().get_mouse_position()
		var rel_position = mouse_pos - center
		var distance = local_to_map(rel_position)
		
		playerPos = get_node('../../Node2D/player').global_position
		var placeBool = dont_place.find(distance)
		
		if get_cell_atlas_coords(0, tile_mouse_pos) == Vector2i(-1,-1) && placeBool == -1 :
			set_cell(0,tile_mouse_pos, source_id, atlas_coord)
			print(distance)
			#print(mouse_position)
			print('')
