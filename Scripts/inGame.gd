extends Node2D
class_name inGame

const portalScene = preload("res://Scenes/Single Elements/portal.tscn")
const monitorScene = preload("res://Scenes/Single Elements/monitor.tscn")
const escalatorScene = preload("res://Scenes/Single Elements/escalator.tscn")
const movableBlockScene = preload("res://Scenes/Single Elements/movable_block.tscn")
const staticBlockScene = preload("res://Scenes/Single Elements/static_block.tscn")
const vaultScene = preload("res://Scenes/Single Elements/vault.tscn")
const energy_core = preload("res://Scenes/Single Elements/energy_core.tscn")

var startingPoint = Global.STARTING_POINT
const tileSize = Global.TILE_SIZE
var gridSize = Global.GRID_SIZE

var tileArray = []

var tileInformation = []

func _ready():
	call_deferred("build_level")
	
func build_level():
	setBoard()	
	setBoardObject()
	setTileInformation()
	setPlayerPosition(getTileInformation(Vector2(0,0)))
	setEnergyCore(getTileInformation(Vector2(1,2)))
	setEnergyCore(getTileInformation(Vector2(2,0)))
	setEnergyCore(getTileInformation(Vector2(3,1)))
	#setPortalPosition(getTileInformation(Vector2(3,0)))
	setVaultPosition(getTileInformation(Vector2(3,3)))
	
func setBoardObject():
	for x in gridSize.x:
		for y in gridSize.y:
			if tileArray[x][y] != null:
				var tile = getTileInformation(Vector2(x,y))
				summonObject(tileArray[x][y], tile, x, y)
				
func setPlayerPosition(tile):
	$char.position.x = tile.position.x
	$char.position.y = tile.position.y+4
	
func setEnergyCore(tile):
	var energy_core = energy_core.instantiate()
	energy_core.position.x = tile.position.x
	energy_core.position.y = tile.position.y
	$TileManager.add_child(energy_core)
	
func setPortalPosition(tile):
	$Portal.position.x = tile.position.x
	$Portal.position.y = tile.position.y	
	
func setVaultPosition(tile):
	var vault = vaultScene.instantiate()
	vault.position.x = tile.position.x
	vault.position.y = tile.position.y-2
	$TileManager.add_child(vault)	
			
func summonObject(objName: String, tile, x ,y):
	var obj
	
	if objName == null:
		return 
	
	if objName == "portal":
		obj = portalScene.instantiate()
	elif objName == "escalator":
		obj = escalatorScene.instantiate()
	elif objName == "movableBlock":
		obj = movableBlockScene.instantiate()
	elif objName == "staticBlock":
		obj = staticBlockScene.instantiate()   
	
	obj.position.x = tile.position.x
	obj.position.y = tile.position.y+4
	obj.z_index = 101
	obj.identityNumber = Vector2(x,y)
	$TileManager.add_child(obj)
	
func getTileInformation(pos = Vector2(0,0)):
	var tiles = $TileManager.get_children()
	for tile in tiles:
		if tile.identityNumber.x == pos.x and tile.identityNumber.y == pos.y:
			return tile
	
func setMonitor(sName: String = 'basicFaceForward', posX: int = 16, posY: int = 16, zIndex : int = 0, iNumber = Vector2(0,0)):
	var monitor = monitorScene.instantiate()
	monitor.spriteName = sName
	monitor.position.x += posX
	monitor.position.y += posY
	monitor.identityNumber.x = iNumber.x
	monitor.identityNumber.y = iNumber.y
	monitor.z_index = zIndex
	$TileManager.add_child(monitor)
	
func setTileInformation():
	var newArr = []
	for x in gridSize.x:
		for y in gridSize.y:
			newArr.append(null)
			if y == gridSize.y-1:
				tileInformation.append(newArr)
				newArr = []
	
func setBoard():
	var maxIndex = 100
	var forX = 0
	var forY = 0
	for x in gridSize.x:
		for y in gridSize.y:
			if y == 0:
				setMonitor('basicFaceDown', startingPoint.x+(tileSize*x), startingPoint.y+(tileSize*y), maxIndex, Vector2(x,y))
			elif y == gridSize.y-1:
				setMonitor('basicFaceUp', startingPoint.x+(tileSize*x), startingPoint.y+(tileSize*y), maxIndex, Vector2(x,y))
			else:
				setMonitor('basicFaceForward', startingPoint.x+(tileSize*x), startingPoint.y+(tileSize*y), maxIndex, Vector2(x,y))
