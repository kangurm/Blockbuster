extends Node2D

signal transfered
const fuelValue = globals.fuel_value
const furnaceTimer = [30, 180, 240, 300, 300]
const furnaceConsumption = [1, 2, 4, 8, 8]
const upgradeCost = [2,20,60,100, 100]
var furnaceTier = 0
var fuelConsumed = 0
var fuelStored = 0
var countdown_time = furnaceTimer[furnaceTier]


func _input (event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		
		var sprite = get_node("StaticBody2D/Sprite2D")
		var sprite_rect = sprite.get_rect()
		var local_mouse_pos = sprite.to_local(get_global_mouse_position())
		if sprite_rect.has_point(local_mouse_pos):
			transferBlocksToFurnace()
			print("Fuel Consumed:", fuelConsumed)
			print("Fuel Stored:", fuelStored)
			emit_signal("transfered", "all")
			if fuelConsumed > upgradeCost[furnaceTier] and furnaceTier<4:
				globals.toolTier+=1
				furnaceTier+=1
				print(globals.toolTier)
			
			
	
	
	
	#
	#if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		#$OneSecondTimer.start()
		##print(globals.block_inv)

func transferBlocksToFurnace():
	for block in globals.block_inv:
		#print(block, globals.block_inv[block])
		#globals.refinery_inv[block] += globals.block_inv[block]
		fuelStored += fuelValue[block] * globals.block_inv[block]
		countdown_time += fuelValue[block] * globals.block_inv[block]		
		globals.block_inv[block] = 0
	#print("Block inv: ", globals.block_inv)
	#print("Refiner inv: ", globals.refinery_inv)
	
	

func _on_countdown_tick():
	if countdown_time > 0:
		if fuelStored > 0.1 and furnaceTier < 4:
			fuelConsumed += furnaceConsumption[furnaceTier]
			fuelStored -= furnaceConsumption[furnaceTier]
		countdown_time -= 1
		if countdown_time > furnaceTimer[furnaceTier]:
			$Label.text = str(furnaceTimer[furnaceTier])
		else:
			$Label.text = str(countdown_time)
		
		$ProgressBar.value = furnaceTimer[furnaceTier] - countdown_time
		if countdown_time == 0:
			$OneSecondTimer.stop()

func clearPlayerInventroy():
	print("Before:", globals.block_inv)
	for key in globals.block_inv:
		# Insert the key and value into a text string
		print("index: %s, value: %d" % [key, globals.block_inv[key]])
