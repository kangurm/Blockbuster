extends Node2D

@onready var tile_map = $TileMap
@onready var player = $player
@onready var refinery = $Refinery
@onready var hud = $player/Hud
var score = 0

func _ready():
	#reset globals
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
	
	#connect signals
	tile_map.tile_broken.connect(player._on_tile_broken)
	tile_map.tile_broken.connect(hud._update_inventory_UI)
	refinery.transfered.connect(hud._update_inventory_UI)
	
