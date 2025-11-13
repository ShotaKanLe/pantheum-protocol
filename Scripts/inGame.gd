extends Node2D

const portalScene = preload("res://Scenes/Single Elements/portal.tscn")

const monitorScene = preload("res://Scenes/Single Elements/monitor.tscn")
const startingPoint = Vector2(-120,-100)
const tileSize = 32
const gridSize = Vector2(2,2)

var tileArray = [[
	'portal', null
], [null, null]]

var tileInformation = []

func _ready():
	setBoard()
	#setBoardObject()
	setTileInformation()
	setPlayerPosition(getTileInformation(Vector2(1,0)))
	pass

func _process(delta):
	movementCharacter()
	
func setBoardObject():
	for x in gridSize.x:
		for y in gridSize.y:
			if tileArray[x][y] != null:
				var element = summonObject(tileArray[x][y])
				var tile = getTileInformation(Vector2(x,y))
				element.position.x = tile.position.x
				element.position.y = tile.position.y+4
		
func movementCharacter():
	if Input.is_action_just_pressed("up"):
		var player = getPlayerInformation()
		player.y -= 1
		if (player.y >= 0 and player.y <= gridSize.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
	elif Input.is_action_just_pressed("down"):
		var player = getPlayerInformation()
		player.y += 1
		if (player.y >= 0 and player.y <= gridSize.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
	elif Input.is_action_just_pressed("left"):
		var player = getPlayerInformation()
		player.x -= 1
		if (player.x >= 0 and player.x <= gridSize.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
	elif Input.is_action_just_pressed("right"):
		var player = getPlayerInformation()
		player.x += 1
		if (player.x >= 0 and player.x <= gridSize.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
			
func summonObject(objName: String):
	var obj
	if objName == "portal":
		obj = monitorScene.instantiate()
		
	return obj
	
		
func getPlayerInformation():
	return $char.identityNumber
	
func updatePlayerInformation(newPos):
	$char.identityNumber = newPos
		
func setPlayerPosition(tile):
	$char.position.x = tile.position.x
	$char.position.y = tile.position.y+4
	
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
