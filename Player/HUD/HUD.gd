extends Node2D

@onready var prefix_inv = $CanvasLayer/Control/HFlowContainer
var atlas_texture = preload("res://placeholder.png")

func UI_add_inventory_container(key):
	# create a box container to hold texture and label
	var vertical_container = VFlowContainer.new()
	vertical_container.set_name(key)
	vertical_container.custom_minimum_size = Vector2(0, 200)
	prefix_inv.add_child(vertical_container)	
	
	# add texture rect to box container
	var texture_rect = TextureRect.new()
	texture_rect.set_name(key)
	texture_rect.custom_minimum_size = Vector2(100, 100)
	vertical_container.add_child(texture_rect)	
	
	if key in globals.texture_regions:
		var region = globals.texture_regions[key]
		var atlas_tex = AtlasTexture.new()
		atlas_tex.atlas = atlas_texture
		atlas_tex.region = region
		texture_rect.texture = atlas_tex
		#texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
		print("added texture")
	else:
		print("Texture for key not found:", key)

	# add label as a child to box container
	var label = Label.new()
	label.set_name("label" + key)
	label.text = str(globals.block_inv[key])
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_FILL
	vertical_container.add_child(label)	
	
	print("Finished creating container")

func UI_remove_inventory_container():
	print("yahoo")

func UI_update_item_count(key):
	prefix_inv.get_node(key).get_node("label" + key).text = str(globals.block_inv[key])

func _update_inventory_UI(key):
	if key == "all":
		for child in prefix_inv.get_children():
			child.queue_free()
		return
	print(key)
	if (globals.block_inv[key] > 0 && prefix_inv.has_node(key)) :
		UI_update_item_count(key)
		return
	UI_add_inventory_container(key)
	#for key in globals.block_inv.keys():
		#if globals.block_inv[key] >= 0 and not prefix_inv.has_node(key):
			#UI_add_inventory_container(key)
