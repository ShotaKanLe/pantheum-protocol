extends Node2D

const LEVEL_GRID_SIZE = Vector2(7, 6)
const LEVEL_TILE_ARRAY = [
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],	
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
	[null, null, null, null, null, null],
]
const STARTING_POINT = Vector2(-100, -80)

func _ready():
	var in_game_instance = $inGame as inGame

	in_game_instance.gridSize = LEVEL_GRID_SIZE
	in_game_instance.tileArray = LEVEL_TILE_ARRAY
	in_game_instance.startingPoint = STARTING_POINT
