extends Node2D
class_name GameController

const portalScene = preload("res://Scenes/Single Elements/portal.tscn")
const energyScene = preload("res://Scenes/Single Elements/energy.tscn")
const buttonScene = preload("res://Scenes/Single Elements/button.tscn")
const pressureScene = preload("res://Scenes/Single Elements/pressure_plate.tscn")
const escalatorScene = preload("res://Scenes/Single Elements/escalator.tscn")
const fragileScene = preload("res://Scenes/Single Elements/fragile.tscn")
const movingBlckScene = preload("res://Scenes/Single Elements/movable_block.tscn")
const monitorScene = preload("res://Scenes/Single Elements/monitor.tscn")
const vaultScene = preload("res://Scenes/Single Elements/vault.tscn")
const hiddenScene = preload("res://Scenes/Single Elements/hidden.tscn")
const beeScene = preload("res://Scenes/Single Elements/bee.tscn")
var portalsPosition = []
var escalatorsPosition = []
@onready var timer = $Timer
@onready var count_down_label = $CountdownContainer/CountDownLabel

var portal_cooldown := false
var energy = 0
var countdown_value := 10

# Energy & Countdown
func add_energy():
	energy += 1

	if energy == 3:
		start_countdown()

# Start countdown from 10
func start_countdown():
	countdown_value = 10
	count_down_label.visible = true
	count_down_label.text = str(countdown_value)
	timer.start()  # Timer ticks every 1 second

# Called every second (connect Timer.timeout to this)
func _on_timer_timeout():
	countdown_value -= 1
	count_down_label.text = str(countdown_value)

	# When countdown ends
	if countdown_value <= 0:
		timer.stop()
		_on_countdown_finished()

func _on_countdown_finished():
	count_down_label.text = "Game Over!"
	get_tree().reload_current_scene()
	# Example: reset energy, spawn portal, etc

const tileSize = 32
const startingPoint = Vector2(-120, -100)
var gridSize = Vector2i(6, 6)

var tileArray = [
	[null, null, 'broken', 'fragile', null, null],
	[null, {type="bee", path=[Vector2(0, 1),Vector2(0, 1),Vector2(0,1),Vector2(1,0),Vector2(1,0), Vector2(-1,0),Vector2(-1,0), Vector2(0,-1), Vector2(0,-1), Vector2(0,-1)] }, null, null, 'energy', null],
	['fragile', null, 'movingBlock', 'escalator', null, 'portal'],
	[{type="button", mech="portal"}, 'portal', 'energy', 'escalator', null, 'vault'],
	[null, null, null, null, 'fragile', null],
	['energy', null, {type="pressure", mech="escalator"}, 'fragile', 'hidden', 'energy']
]


func _ready():
	add_to_group("GameController")
	setBoard()
	spawnTiles()
	setPlayerPosition(getTileInformation(Vector2(1,0)))

func _process(delta):
	movementCharacter()

# ---------------------------------------------------------
# TILE CREATION
# ---------------------------------------------------------

func spawnTiles():
	for x in gridSize.x:
		for y in gridSize.y:
			var tile_type = tileArray[y][x]
			if tile_type is Dictionary:
				if tile_type.type ==  "button":
					var f = buttonScene.instantiate()
					f.identityNumber = Vector2(x,y)
					f.action_value = tile_type.mech
					$TileManager.add_child(f)
					set_object_position(f, x, y)
				if tile_type.type ==  "pressure":
					var f = pressureScene.instantiate()
					f.identityNumber = Vector2(x,y)
					f.action_value = tile_type.mech
					$TileManager.add_child(f)
					set_object_position(f, x, y)
				if tile_type.type == "bee":
					var b = beeScene.instantiate()
					b.identityNumber = Vector2(x, y)
					b.path = tile_type.path     # give its movement path
					$TileManager.add_child(b)
					set_object_position(b, x, y)

			else:
				if tile_type == "portal":
					var p = portalScene.instantiate()
					p.identityNumber = Vector2(x,y)
					portalsPosition.append(p.identityNumber)
					p.target_position = get_other_portal(x,y)
					$portalManager.add_child(p)
					set_object_position(p, x, y)
				elif tile_type == "fragile" or tile_type == "broken": # <-- Tangani kedua tipe
					var f = fragileScene.instantiate()
					f.identityNumber = Vector2(x,y)
					
					# VITAL FIX: Mengatur status broken awal
					if tile_type == "broken":
						f.start_broken = true # <-- Atur variabel baru yang Anda buat
					
					$TileManager.add_child(f)
					set_object_position(f, x, y)
				elif tile_type == "energy":
					var f = energyScene.instantiate()
					f.identityNumber = Vector2(x,y)
					$TileManager.add_child(f)
					set_object_position(f, x, y)
				elif tile_type == "escalator":
					var f = escalatorScene.instantiate()
					f.identityNumber = Vector2(x,y)
					escalatorsPosition.append(f.identityNumber)
					$escalatorManager.add_child(f)
					set_object_position(f, x, y)
				elif tile_type == "movingBlock":
					var f = movingBlckScene.instantiate()
					f.identityNumber = Vector2(x,y)
					$TileManager.add_child(f)
					set_object_position(f, x, y)
				elif tile_type == "vault":
					var f = vaultScene.instantiate()
					f.identityNumber = Vector2(x,y)
					$TileManager.add_child(f)
					set_object_position(f, x, y)
				elif tile_type == "hidden":
					var f = hiddenScene.instantiate()
					f.identityNumber = Vector2(x,y)
					$HiddenManager.add_child(f)
					set_object_position(f, x, y)
					
	#Play Hidden Animation
	var hiddens = $HiddenManager.get_children()
	for hidden in hiddens:
		hidden.play_anim()
	

func set_object_position(obj, x, y):
	var tile = getTileInformation(Vector2(x,y))

	var offset_y = 4  # default offset

	# jika tile di row paling bawah → naik 10px
	if y == gridSize.y - 1:
		offset_y -= 6   # contoh: 4 - 10 = -6

	obj.position = Vector2(tile.position.x, tile.position.y + offset_y)

func get_other_portal(x,y):
	for i in gridSize.x:
		for j in gridSize.y:
			if !tileArray[j][i] is Dictionary:
				if tileArray[j][i] == "portal" and (i != x or j != y):
					return Vector2(i,j)
	return Vector2(0,0)

func find_adjacent_empty_tile(pos: Vector2) -> Vector2:
	# Cek 4 arah (Kanan, Kiri, Bawah, Atas)
	var directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
	
	for dir in directions:
		var check_pos = pos + dir
		var y = int(check_pos.y)
		var x = int(check_pos.x)

		# Cek batas grid
		if x >= 0 and x < gridSize.x and y >= 0 and y < gridSize.y:
			# Cek apakah tile kosong (null)
			if tileArray[y][x] == null:
				return check_pos
	
	# Jika tidak ada tile kosong yang berdekatan
	return Vector2(-1, -1)

# ---------------------------------------------------------
# PLAYER MOVEMENT
# ---------------------------------------------------------

func movementCharacter():
	var cur = $char.identityNumber
	var next = cur

	if Input.is_action_just_pressed("up"):    next.y -= 1
	if Input.is_action_just_pressed("down"):  next.y += 1
	if Input.is_action_just_pressed("left"):  next.x -= 1
	if Input.is_action_just_pressed("right"): next.x += 1

	if next == cur:
		return

	# check west tile
	if next.x < 0 or next.y < 0 or next.x >= gridSize.x or next.y >= gridSize.y:
		return

	var t = tileArray[next.y][next.x]

	# Kalau tile kosong → langsung jalan
	if t is Dictionary:
		setPlayerPosition(getTileInformation(next))
		$char.identityNumber = next
		return
	if t == null or  t == "vault" or t == "fragile" or t == "energy" or t == "portal" or t == "button" or t == "pressure" or t == "escalator" or t == "hidden":
		setPlayerPosition(getTileInformation(next))
		$char.identityNumber = next
		return

	# Kalau tile adalah block → cek apakah block bisa didorong
	if t == "movingBlock":
		var push_dir = next - cur
		var block_target = next + push_dir

		# Block hanya boleh didorong jika tile di belakangnya kosong
		if is_block_pushable(block_target):
			push_block(next, block_target)

			# setelah block bergerak → player boleh maju
			setPlayerPosition(getTileInformation(next))
			$char.identityNumber = next
		return

	# Jika tile tidak boleh diinjak → stop
	return
	
func push_block(from: Vector2i, to: Vector2i):
	# update tileArray
	tileArray[to.y][to.x] = "movingBlock"
	tileArray[from.y][from.x] = null

	# pindahkan node-nya
	for tile in $TileManager.get_children():
		if tile is MovableBlock and Vector2i(tile.identityNumber) == from:
			tile.identityNumber = to
			
			var tile_info = getTileInformation(to)
			
			# ---------------------------
			# APPLY SAME OFFSET LOGIC HERE
			# ---------------------------
			var offset_y := 4
			if to.y == gridSize.y - 1:
				offset_y -= 6   # sama seperti set_object_position()

			tile.global_position = Vector2(
				tile_info.position.x,
				tile_info.position.y + offset_y
			)

			return



# ---------------------------------------------------------
# WHEN FRAGILE BREAKS
# ---------------------------------------------------------

func on_tile_broken(pos: Vector2):
	tileArray[int(pos.y)][int(pos.x)] = "broken"
	
func on_tile_res(pos: Vector2):
	tileArray[int(pos.y)][int(pos.x)] = null
# ---------------------------------------------------------
# POSITION HELPERS
# ---------------------------------------------------------

func setPlayerPosition(tile):
	var x = tile.identityNumber.x
	var y = tile.identityNumber.y

	var offset_y = 4

	if y == gridSize.y - 1:
		offset_y -= 6
	print(tile.position.y)
	$char.position = Vector2(tile.position.x, tile.position.y + offset_y)


func getTileInformation(pos: Vector2):
	for tile in $TileManager.get_children():
		if tile.identityNumber == pos:
			return tile
	return null

func getPortalInformation(pos: Vector2):
	for tile in $portalManager.get_children():
		if tile.identityNumber == pos:
			return tile
	return null
	
func getEscalatorInformation(pos: Vector2):
	for tile in $escalatorManager.get_children():
		if tile.identityNumber == pos:
			return tile
	return null
# ---------------------------------------------------------
# MONITORS
# ---------------------------------------------------------

func setBoard():
	var maxIndex = 100
	for x in gridSize.x:
		for y in gridSize.y:
			var sprite = "basicFaceForward"
			if y == 0:
				sprite = "basicFaceDown"
			elif y == gridSize.y-1:
				sprite = "basicFaceUp"

			var monitor = monitorScene.instantiate()
			monitor.spriteName = sprite
			monitor.identityNumber = Vector2(x,y)
			monitor.position = startingPoint + Vector2(tileSize*x, tileSize*y)
			monitor.z_index = -1
			$TileManager.add_child(monitor)

# ---------------------------------------------------------
# PORTAL TELEPORT
# ---------------------------------------------------------

func teleport_player(dest: Vector2):
	setPlayerPosition(getTileInformation(dest))
	$char.identityNumber = dest

func is_walkable(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.y < 0: return false
	if pos.x >= gridSize.x or pos.y >= gridSize.y: return false

	var t = tileArray[pos.y][pos.x]
	if t is Dictionary:
		return true
	if t == "broken":
		return false
	# tile yang boleh dimasuki player
	if  t == "vault" or t == "fragile" or t == "energy" or t == "portal" or t == "button" or t == "pressure" or t == "escalator" or t == "hidden":
		return true
	return t == null
	
func is_block_pushable(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.y < 0: return false
	if pos.x >= gridSize.x or pos.y >= gridSize.y: return false

	var t = tileArray[pos.y][pos.x]
	if t is Dictionary:
		return true
	# hanya boleh pindah ke tile kosong
	if t == "broken":
		return false
	if t == "fragile" or t == "button" or t == "pressure" or t == "energy" or t == "escalator" or t == "hidden":
		return true
	return t == null

func is_cell_free(cell: Vector2i) -> bool:
	# 1. Check boundaries
	if cell.x < 0 or cell.y < 0:
		return false
	if cell.x >= gridSize.x or cell.y >= gridSize.y:
		return false

	# 2. World position of that tile
	var world_pos = startingPoint + Vector2(cell.x * tileSize, cell.y * tileSize)

	# 3. Check if something is inside that space
	var space = get_world_2d().direct_space_state

	var q = PhysicsPointQueryParameters2D.new()
	q.position = world_pos
	q.collision_mask = 1 << 0   # check layer 1 (your special tile layer)

	var result = space.intersect_point(q)

	return result.is_empty()
	

func execute_action(action_type: String, action_value: String, target: Vector2):
	print("ACTION:", action_type, action_value, target)

	if action_type == "spawn":
		print("spawned")
		spawn_mechanic(action_value, target)
	if action_type == "despawn":
		print("despawned")
		despawn_mechanic(action_value, target)


	# mau expand lagi? tinggal tambah if baru di sini
# Activate Special Tiles
func spawn_mechanic(mechanic: String, pos: Vector2):
	var y = int(pos.y)
	var x = int(pos.x)
	
	# 1. Cek apakah ada Node interaktif yang sudah ada di posisi target
	var existing_node = getTileInformation(pos)
	print(existing_node)
	# --- LOGIKA TILE TUNGGAL (ACTIVATE) ---
	if mechanic == "escalator":
			var escalators = $escalatorManager.get_children()
			print(escalators)
			for escalator in escalators:
				escalator.activated()
				print(escalator.identityNumber)
			return 
		
	# --- LOGIKA PORTAL BERPASANGAN (ACTIVATE/SPAWN) ---
	if mechanic == "portal":
			var portals = $portalManager.get_children()
			print(portals)
			for portal in portals:
				portal.activated()
				print(portal.identityNumber)

			return 
		
	return
# Deactivate Special Tiles
func despawn_mechanic(mechanic: String, pos: Vector2):
	var y = int(pos.y)
	var x = int(pos.x)
	
	# 1. Cek apakah ada Node interaktif yang sudah ada di posisi target
	var existing_node = getTileInformation(pos)
	# --- LOGIKA PORTAL BERPASANGAN (ACTIVATE/SPAWN) ---
	if mechanic == "portal":
		var portals = $portalManager.get_children()
		print(portalsPosition)
		for portal in portals:
			portal.deactivated()
			print(portal.deactivated())
		
		return
	if mechanic == "escalator":
		var escalators = $escalatorManager.get_children()
		print(escalatorsPosition)
		for escalator in escalators:
			escalator.deactivated()
			print(escalator.deactivated())
		
		return

func get_tile_world_position(x: int, y: int) -> Vector2:
	var tile = getTileInformation(Vector2(x, y))
	var offset_y := 4
	if y == gridSize.y - 1:
		offset_y -= 6
	return Vector2(tile.position.x, tile.position.y + offset_y)

