extends Node2D

@onready var tile_map = $TileMap
@onready var player = $player
@onready var refinery = $Refinery
@onready var hud = $player/Hud
var score = 0

func _ready():
	$AudioStreamPlayer.play()
	#reset globals
	globals.wait = float(0.1)
	globals.reach = 20
	globals.zoom = 4
	globals.refinery_inv = {
	"stone": 0,
	"granite": 0,
	"obsidian": 0,
	"oil_shale": 0,
	"uranium": 0,
}
	globals.block_inv = {
		"stone": 0,
		"granite": 0,
		"obsidian": 0,
		"oil_shale": 0,
		"uranium": 0,
}
	globals.toolTier = 0
	globals.catReached = false
	
	#connect signals
	tile_map.tile_broken.connect(player._on_tile_broken)
	tile_map.tile_broken.connect(hud._update_inventory_UI)
	tile_map.object_thrown.connect(player._thrown)
	#refinery.transfered.connect(hud._update_inventory_UI)
	refinery.progressbar.connect(hud._update_onscreen_progressbar)
	refinery.transfered.connect(hud._update_inventory_UI)
	tile_map.block_placed.connect(hud._update_inventory_UI)
	
