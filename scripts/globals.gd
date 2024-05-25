extends Node

var toolTier = 0

const fuel_value = {
	"dirt": 16,
	"stone": 8,
	"granite": 4,
	"obsidian": 2,
	"oil_shale": 1,
}

var refinery_inv = {
	"dirt": 0,
	"stone": 0,
	"granite": 0,
	"obsidian": 0,
	"oil_shale": 0,
}

var block_inv = {
	"dirt": 0,
	"stone": 0,
	"granite": 0,
	"obsidian": 0,
	"oil_shale": 0,
}

var texture_regions = {
	"dirt": Rect2(0, 0, 16, 16),  # Example region, adjust coordinates and size as needed
	"stone": Rect2(0, 16, 16, 16),  # Example region, adjust coordinates and size as needed
	"granite": Rect2(0, 32, 16, 16),  # Example region, adjust coordinates and size as needed
	"obsidian": Rect2(0, 48, 16, 16),  # Example region, adjust coordinates and size as needed
	"oil_shale": Rect2(0, 64, 16, 16)  # Example region, adjust coordinates and size as needed
}
