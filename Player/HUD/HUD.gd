extends Node2D

@onready var main_node = get_node("../../TileMap")  # Adjust the path as needed
@onready var block_inventory = main_node.block_inv
@onready var prefix = $CanvasLayer/Control/HFlowContainer


func _update_inventory_UI():
	prefix.get_node("Block1_Count/Label").text = str(block_inventory["dirt"])
	for i in block_inventory:
		for j in block_inventory[i]:
			if j >= 0 && prefix.has_node(i):
				var box_container = BoxContainer.new()
				box_container.set_name(i)
				prefix.add_child(box_container)
				print("added: ", i)
	
