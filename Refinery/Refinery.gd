extends Node2D

signal transfered
const fuelValue = globals.fuel_value
const furnaceTimer = [120, 180, 240, 300]
const furnaceConsumption = [0.2, 0.4, 0.8, 1.6]
var furnaceTier = 0
var fuelConsumed = 0
var countdown_time = furnaceTimer[furnaceTier]


func _input (event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		
		var sprite = get_node("StaticBody2D/Sprite2D")
		var sprite_rect = sprite.get_rect()
		var local_mouse_pos = sprite.to_local(get_global_mouse_position())
		if sprite_rect.has_point(local_mouse_pos):
			print("Furnace was clicked")
			transferBlocksToFurnace()
			print("Fuel Consumed:", fuelConsumed)
			emit_signal("transfered", "all")
			
			
	
	
	
	#
	#if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		#$OneSecondTimer.start()
		##print(globals.block_inv)

func transferBlocksToFurnace():
	for block in globals.block_inv:
		#print(block, globals.block_inv[block])
		#globals.refinery_inv[block] += globals.block_inv[block]
		countdown_time += fuelValue[block] * globals.block_inv[block]		
		globals.block_inv[block] = 0
	#print("Block inv: ", globals.block_inv)
	#print("Refiner inv: ", globals.refinery_inv)
	
	

func _on_countdown_tick():
	if countdown_time > 0:
		#print(countdown_time)
		if countdown_time > furnaceTimer[furnaceTier]:
			fuelConsumed += furnaceConsumption[furnaceTier]
		countdown_time -= 1
		$Label.text = str(countdown_time)
		$ProgressBar.value = furnaceTimer[furnaceTier] - countdown_time
		#print($ProgressBar.value)
		if countdown_time == 0:
			$OneSecondTimer.stop()

func clearPlayerInventroy():
	print("Before:", globals.block_inv)
	for key in globals.block_inv:
		# Insert the key and value into a text string
		print("index: %s, value: %d" % [key, globals.block_inv[key]])
