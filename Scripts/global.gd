extends Node

const STARTING_POINT = Vector2(-120,-100)
const TILE_SIZE = 32
const GRID_SIZE = Vector2(3,3)

var statusLevel
var statusLevelDesign = 0
var statusLevelProgram = 0
var statusLevelNetwork = 0
var statusLevelTutorial = 0

var isProlog = true
var isEpilog = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
