extends Node2D

const constantName = 'movableBlock'
var identityNumber : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	var obj = area.get_parent()
			
func moveBlock(direction):
	
	var tempIdentity = identityNumber
	
	if direction == 'up':
		tempIdentity.y += 1
	elif direction == 'down':
		tempIdentity.y -= 1
	elif direction == 'left':
		tempIdentity.x += 1
	elif direction == 'right':
		tempIdentity.x -= 1
		
	if(!((tempIdentity.y >= 0 and tempIdentity.y <= Global.GRID_SIZE.x-1) and (tempIdentity.x >= 0 and tempIdentity.x <= Global.GRID_SIZE.y-1))):
		return 'idle'

	identityNumber = tempIdentity
	setBlockPosition(getTileInformation(identityNumber))
	updateBlockInformation(identityNumber)
	
func setBlockPosition(tile):
	position.x = tile.position.x
	position.y = tile.position.y+4
	
func getTileInformation(pos = Vector2(0,0)):
	var parent = get_parent().get_parent()
	var tileManager = parent.get_child(2)
	var tiles = tileManager.get_children()
	for tile in tiles:
		if tile.identityNumber.x == pos.x and tile.identityNumber.y == pos.y:
			return tile
			
func updateBlockInformation(newPos):
	identityNumber = newPos

