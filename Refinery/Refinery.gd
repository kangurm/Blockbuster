extends Node2D

signal transfered
const fuelValue = globals.fuel_value
const furnaceTimer = [30, 60, 90, 300, 300]
const furnaceConsumption = [1, 2, 4, 8, 8]
const upgradeCost = [2,20,60,100, 100]
var furnaceTier = 0
var fuelConsumed = 0
var fuelStored = 0
var countdown_time = furnaceTimer[furnaceTier]
var warn1 = preload("res://Sounds/refinery warning.wav")
var warn2 = preload("res://Sounds/refinerywarn2.wav")
var warn3 = preload("res://Sounds/refinerywarn3.wav")
var upgrade_tool = preload("res://Sounds/upgradepickup.wav")
@onready var audio_player = $AudioStreamPlayer
signal progressbar


func _input (event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#if globals.catReached == false:
				#get_tree().change_scene_to_file("res://win.tscn")
		var sprite = get_node("StaticBody2D/Sprite2D")
		var sprite_rect = sprite.get_rect()
		var local_mouse_pos = sprite.to_local(get_global_mouse_position())
		if sprite_rect.has_point(local_mouse_pos):
			if globals.catReached == true:
				get_tree().change_scene_to_file("res://win.tscn")
			transferBlocksToFurnace()
			print("Fuel Consumed:", fuelConsumed)
			print("Fuel Stored:", fuelStored)
			emit_signal("transfered", "all")
			if fuelConsumed >= upgradeCost[furnaceTier] and furnaceTier<4:
				furnaceTier+=1
				update_icons()
				var bar_suhe = $ProgressBar.max_value / $ProgressBar.value
				$ProgressBar.max_value = furnaceTimer[furnaceTier]
				$ProgressBar.value = $ProgressBar.max_value / bar_suhe
				countdown_time = $ProgressBar.max_value - $ProgressBar.value
				fuelConsumed = 0
				globals.toolTier = furnaceTier
				globals.wait += 0.1
				globals.reach += 5
				audio_player.stream = upgrade_tool
				audio_player.play()
				print(globals.toolTier)
			
			
	#
	#if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		#$OneSecondTimer.start()
		##print(globals.block_inv)

func update_labels():
	if $HFlowContainer:
		$HFlowContainer/FuelConsumed.text = str(fuelConsumed)
		$HFlowContainer/UpgradeCost.text = str(upgradeCost[furnaceTier])
		
func update_icons():
	if furnaceTier == 1:
		var new_texture_path = "res://Tiers/tier2_icon.png"
		var new_texture = load(new_texture_path)
		$HFlowContainer/TextureRect.texture = new_texture
	if furnaceTier == 2:
		var new_texture_path = "res://Tiers/tier3_icon.png"
		var new_texture = load(new_texture_path)
		$HFlowContainer/TextureRect.texture = new_texture
	if furnaceTier == 3:
		var new_texture_path = "res://Tiers/tier4_icon.png"
		var new_texture = load(new_texture_path)
		$HFlowContainer/TextureRect.texture = new_texture
	if furnaceTier == 4:
		$HFlowContainer.queue_free()
	#$HFlowContainer/TextureRect.texture = 

func transferBlocksToFurnace():
	for block in globals.block_inv:
		#print(block, globals.block_inv[block])
		#globals.refinery_inv[block] += globals.block_inv[block]
		fuelStored += fuelValue[block] * globals.block_inv[block]
		countdown_time += fuelValue[block] * globals.block_inv[block]
		$ProgressBar.value -= fuelValue[block] * globals.block_inv[block]
		globals.block_inv[block] = 0
	#print("Block inv: ", globals.block_inv)
	#print("Refiner inv: ", globals.refinery_inv)
	
	

func _on_countdown_tick():
	print("time ", countdown_time)
	if countdown_time > 0:
		if fuelStored > 0.1 and furnaceTier < 4:
			fuelConsumed += furnaceConsumption[furnaceTier]
			fuelStored -= furnaceConsumption[furnaceTier]
		countdown_time -= 1
		$ProgressBar.value += 1
		emit_signal("progressbar", $ProgressBar.value, $ProgressBar.max_value)
		if countdown_time > furnaceTimer[furnaceTier]:
			$Label.text = str(furnaceTimer[furnaceTier])
		else:
			$Label.text = str(countdown_time)
		
		#$ProgressBar.value = furnaceTimer[furnaceTier] - countdown_time
		if countdown_time == 0:
			get_tree().change_scene_to_file("res://lose.tscn")
			$OneSecondTimer.stop()
		update_labels()
	
	#warning sounds
	if countdown_time == furnaceTimer[furnaceTier]/2:
		audio_player.stream = warn1
		audio_player.play()
	if countdown_time == furnaceTimer[furnaceTier]/3:
		audio_player.stream = warn2
		audio_player.play()
	if countdown_time == furnaceTimer[furnaceTier]/5:
		audio_player.stream = warn3
		audio_player.play()
		
func clearPlayerInventroy():
	print("Before:", globals.block_inv)
	for key in globals.block_inv:
		# Insert the key and value into a text string
		print("index: %s, value: %d" % [key, globals.block_inv[key]])
