extends Node2D

@onready var prefix_inv = $CanvasLayer/Control/HFlowContainer

func UI_add_inventory_container(key):
	# create a box container to hold texture and label
	var box_container = BoxContainer.new()
	box_container.set_name(key)
	prefix_inv.add_child(box_container)  # Use the variable, not the class name

	# add texture rect to box container
	var texture_rect = TextureRect.new()
	texture_rect.set_name(key)
	box_container.add_child(texture_rect)

	# add label as a child to box container
	var label = Label.new()
	label.set_name(key)
	box_container.add_child(label)
	
	print("Finished creating container")

func UI_remove_inventory_container():
	print("yahoo")

func _update_inventory_UI():
	for key in globals.block_inv.keys():
		if globals.block_inv[key] >= 0 and not prefix_inv.has_node(key):
			UI_add_inventory_container(key)
