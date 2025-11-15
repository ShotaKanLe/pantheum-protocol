extends Node2D

const portalScene = preload("res://Scenes/Single Elements/portal.tscn")
const monitorScene = preload("res://Scenes/Single Elements/monitor.tscn")
const escalatorScene = preload("res://Scenes/Single Elements/escalator.tscn")
const movableBlockScene = preload("res://Scenes/Single Elements/movable_block.tscn")
const staticBlockScene = preload("res://Scenes/Single Elements/static_block.tscn")

const startingPoint = Global.STARTING_POINT
const tileSize = Global.TILE_SIZE
const gridSize = Global.GRID_SIZE

var tileArray = [[
	null, 'portal', null
], [null, null, null], [null, null, 'portal']]

var tileInformation = []

const abigail = "res://Assets/Head/Abigail.png"
const atlas = "res://Assets/Head/Atlas.png"
const clorina = "res://Assets/Head/Clorina.png"
const darkCyber = "res://Assets/Head/DarkCyber.png"
const dyland = "res://Assets/Head/Dyland.png"
const innera = "res://Assets/Head/Innera.png"
const lyna = "res://Assets/Head/Lyna.png"
const nefa = "res://Assets/Head/Nefa.png"
const vanir = "res://Assets/Head/Vanir.png"
const venrir = "res://Assets/Head/Venrir.png"
const xein = "res://Assets/Head/Xein.png"

var characterPlayed = 'clorina'

func playAs(char):
	pass
	
func setAvatar(name):
	var forName
	
	if name == 'abigail':
		forName = 'Abigail'
		name = abigail
	elif name == 'atlas':
		forName = 'Atlas'
		name = atlas
	elif name == 'clorina':
		forName = 'Clorina'
		name = clorina
	elif name == '???':
		forName = '???'
		name = darkCyber
	elif name == 'dyland': 
		forName = 'Dyland'
		name = dyland
	elif name == 'innera':
		forName = 'Innera'
		name = innera
	elif name == 'lyna':
		forName = 'Lyna'
		name = lyna
	elif name == 'nefa':
		forName = 'Nefa'
		name = nefa
	elif name == 'vanir':
		forName = 'Vanir'
		name = vanir
	elif name == 'venrir':
		forName = 'Venrir'
		name =venrir
	elif name == 'xein':
		forName = 'Xein'
		name = xein
		
	$startButton/Node2D/Label.text = forName
	$Node2D/avatarChar.texture = load (name)
	$Node2D/avatarCharShadow.texture = load (name)
	
func _ready():
	$inGame.play()
	setAvatar('dyland')
	setBoard()
	setBoardObject()
	setTileInformation()
	setPlayerPosition(getTileInformation(Vector2(1,0)))
	pass

func _process(delta):
	pass
	
func setBoardObject():
	for x in gridSize.x:
		for y in gridSize.y:
			if tileArray[x][y] != null:
				var tile = getTileInformation(Vector2(x,y))
				summonObject(tileArray[x][y], tile, x, y)
				
func setPlayerPosition(tile):
	$char.position.x = tile.position.x
	$char.position.y = tile.position.y+4
			
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

func _on_button_3_pressed():
	$buttonClick.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file('res://Scenes/main_scene.tscn')
