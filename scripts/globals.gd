extends Node

var toolTier = 0
var catReached = false
var wait = float(0.1)
var reach = 20
var zoom = 4

const fuel_value = {
	"uranium": 16,
	"oil_shale": 8,
	"obsidian": 4,
	"granite": 2,
	"stone": 1,
}

var refinery_inv = {
	"stone": 0,
	"granite": 0,
	"obsidian": 0,
	"oil_shale": 0,
	"uranium": 0,
}

var block_inv = {
	"stone": 0,
	"granite": 0,
	"obsidian": 0,
	"oil_shale": 0,
	"uranium": 0,
}

var texture_regions = {
	"stone": Rect2(0, 0, 16, 16),  # Example region, adjust coordinates and size as needed
	"granite": Rect2(0, 16, 16, 16),  # Example region, adjust coordinates and size as needed
	"obsidian": Rect2(0, 32, 16, 16),  # Example region, adjust coordinates and size as needed
	"oil_shale": Rect2(0, 48, 16, 16),  # Example region, adjust coordinates and size as needed
	"uranium": Rect2(0, 64, 16, 16)  # Example region, adjust coordinates and size as needed
}
