extends Node2D

@onready var tile_map = $TileMap
@onready var player = $player
@onready var refinery = $Refinery
@onready var hud = $player/Hud
var score = 0

func _ready():
	tile_map.tile_broken.connect(player._on_tile_broken)
	tile_map.tile_broken.connect(hud._update_inventory_UI)
	
