extends TileMap

signal tile_broken
signal object_thrown
signal block_placed


#var wait = 0.1
var reach = 40
var current_tile_pos: Vector2i

func break_block(event, tile_atlas_coord, tile_mouse_pos):
	
	var coordX = tile_atlas_coord.x
	var coordY = tile_atlas_coord.y
	var damage = globals.toolTier - coordY +1
	if globals.toolTier >=coordY:
		if coordX + damage < 5 && coordX > -1:
			set_cell(0, tile_mouse_pos,1, Vector2i(coordX+damage, coordY))
			$BlockBreak.play()
		else:
			var block_type
			# Air block
			if coordY == -1:
				return
			if coordY == 4:
				globals.block_inv['uranium'] += 1
				block_type = 'uranium'
			if coordY == 3:
				globals.block_inv['oil_shale'] += 1
				block_type = 'oil_shale'
			if coordY == 2 :
				globals.block_inv['obsidian'] +=1
				block_type = 'obsidian'
			if coordY == 1:
				globals.block_inv['granite'] +=1
				block_type = 'granite'
			if coordY == 0:
				globals.block_inv['stone'] +=1
				block_type = 'stone'
			set_cell(0, tile_mouse_pos, -1)
			emit_signal('tile_broken', block_type)
			

@onready var playerPos =  get_node('../../Node2D/player').global_position
func throw_object(event):
	emit_signal('object_thrown', event.x)
	var sprite = Sprite2D.new()
	if globals.toolTier == 0:
		sprite.texture = load('res://projectile/punch-pixelicious2.png')
	else:
		if globals.toolTier ==1:
			sprite.texture = load('res://projectile/doll.png')
		elif globals.toolTier ==2:
			sprite.texture = load('res://projectile/doll2.png')
		elif globals.toolTier ==3:
			sprite.texture = load('res://projectile/doll3.png')
		elif globals.toolTier ==4:
			sprite.texture = load('res://projectile/doll4.png')
		sprite.rotate(-30)

	playerPos =  get_node('../../Node2D/player').global_position
	
	sprite.scale = Vector2(0.02,0.02)
	sprite.position = playerPos
	sprite.look_at(get_global_mouse_position())
	add_child(sprite)
	
	var tween = create_tween()
	tween.tween_property(sprite, 'position',get_global_mouse_position(), globals.wait)
	await get_tree().create_timer(globals.wait).timeout
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
	if distance.x < globals.reach && distance.x > -globals.reach && distance.y < globals.reach && distance.y > -globals.reach:
		throw_object(distance)
	await get_tree().create_timer(globals.wait).timeout
	
	
	if globals.toolTier == 0:
		if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, tile_mouse_pos) != Vector2i(9,5) && distance.x <globals.reach && distance.x > -globals.reach && distance.y < globals.reach && distance.y > -globals.reach && get_cell_source_id(0, tile_mouse_pos) != 0 :
			break_block(event, tile_atlas_coord, tile_mouse_pos)
	if globals.toolTier == 1:
		for i in 3:
			for j in 3:
				var coord =  Vector2i (tile_mouse_pos.x-1+i, tile_mouse_pos.y-1+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <globals.reach && distance.x > -globals.reach && distance.y < globals.reach && distance.y > -globals.reach && get_cell_source_id(0, coord) != 0 :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if globals.toolTier == 2:
		for i in 5:
			for j in 5:
				var coord =  Vector2i (tile_mouse_pos.x-2+i, tile_mouse_pos.y-2+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <globals.reach && distance.x > -globals.reach && distance.y < globals.reach && distance.y > -globals.reach && get_cell_source_id(0, coord) != 0  :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if globals.toolTier == 3:
		for i in 9:
			for j in 9:
				var coord =  Vector2i (tile_mouse_pos.x-4+i, tile_mouse_pos.y-4+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <globals.reach && distance.x > -globals.reach && distance.y < globals.reach && distance.y > -globals.reach && get_cell_source_id(0, coord) != 0  :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)
	if globals.toolTier == 4:
		for i in 15:
			for j in 15:
				var coord =  Vector2i (tile_mouse_pos.x-7+i, tile_mouse_pos.y-7+j)
				if current_tile_pos != tile_mouse_pos && get_cell_atlas_coords(0, coord) != Vector2i(9,5) && distance.x <globals.reach && distance.x > -globals.reach && distance.y < globals.reach && distance.y > -globals.reach && get_cell_source_id(0, coord) != 0 :
					tile_atlas_coord = get_cell_atlas_coords(0,coord)
					break_block(event, tile_atlas_coord, coord)

var dont_place = [  Vector2i(1, -2), Vector2i(1, -1), Vector2i(1, 0), Vector2i(0, -2), Vector2i(0, -1), Vector2i(0, 0),  Vector2i(-1, -2), Vector2i(-1, -1), Vector2i(-1, 0)]

var currently_breaking = false

func _input (event):
	
	
	if Input.is_action_just_pressed("pressI"):
		if globals.toolTier < 4:
			globals.toolTier += 1
			globals.wait += 0.1
			print('breaker globals.toolTier:', globals.toolTier)
	if Input.is_action_just_pressed("pressJ"):
		if globals.toolTier >0:
			globals.toolTier -=1
			globals.wait -= 0.1
			print('breaker globals.toolTier:', globals.toolTier)
	if Input.is_action_just_pressed("mb_left") && currently_breaking == false:
		currently_breaking = true
		print('mining')
		while true:
			if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
				await mine(event)
			else:
				currently_breaking = false
				print('stop')
				break

	# place blocks
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mouse_position = get_global_mouse_position()
		var tile_mouse_pos = local_to_map(mouse_position)
		var source_id = 1
		var atlas_coord = Vector2i(-1,-1)
		
		var screen_size = get_viewport_rect().size
		var center = Vector2(screen_size.x/2, screen_size.y/2)
		var mouse_pos = get_viewport().get_mouse_position()
		var rel_position = mouse_pos - center
		var distance = local_to_map(rel_position)
		
		var blockUsed
		#print(globals.block_inv)
		if globals.block_inv['uranium'] > 0:
			atlas_coord = Vector2i(0,4)
			blockUsed = 'uranium'
		if globals.block_inv['oil_shale'] > 0:
			atlas_coord = Vector2i(0,3)
			blockUsed = 'oil_shale'
		if globals.block_inv['obsidian'] > 0:
			atlas_coord = Vector2i(0,2)
			blockUsed = 'obsidian'
		if globals.block_inv['granite'] > 0:
			atlas_coord = Vector2i(0,1)
			blockUsed = 'granite'
		if globals.block_inv['stone'] > 0:
			atlas_coord = Vector2i(0,0)
			blockUsed = 'stone'
		playerPos = get_node('../../Node2D/player').global_position
		var placeBool = dont_place.find(distance)
		if atlas_coord != Vector2i(-1,-1) :
			if get_cell_atlas_coords(0, tile_mouse_pos) == Vector2i(-1,-1) && placeBool == -1:
				globals.block_inv[blockUsed] -=1
				emit_signal('block_placed', blockUsed)
				emit_signal('object_thrown', distance.x)
				set_cell(0,tile_mouse_pos, source_id, atlas_coord)
