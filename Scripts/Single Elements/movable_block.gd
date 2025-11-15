<<<<<<< HEAD
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

=======
extends Area2D
class_name MovableBlock
@export var identityNumber: Vector2
@export var move_distance: float = 32.0
@export var move_speed: float = 200.0
@onready var game = get_tree().get_first_node_in_group("GameController")
var target_pos: Vector2
var moving := false

func _ready():
	target_pos = global_position

func _on_body_entered(body):
	if body.name != "char":
		return
	
	var dir = body.last_direction  # where the player came from
	
	# Decide movement based on direction
	if dir == Vector2.UP:       # Player came from BELOW
		target_pos = global_position + Vector2(0, -move_distance)
	elif dir == Vector2.DOWN:   # Player came from ABOVE
		target_pos = global_position + Vector2(0, move_distance)
	elif dir == Vector2.LEFT:   # Player came from RIGHT
		target_pos = global_position + Vector2(-move_distance, 0)
	elif dir == Vector2.RIGHT:  # Player came from LEFT
		target_pos = global_position + Vector2(move_distance, 0)
	
	moving = true
	
func push_to(cell: Vector2i):
	var tile_world = game.get_tile_world_position(cell.x, cell.y)
	target_pos = tile_world
	moving = true
	identityNumber = cell


func _physics_process(delta):
	if moving:
		global_position = global_position.move_toward(target_pos, move_speed * delta)
		
		if global_position == target_pos:
			moving = false
>>>>>>> origin/fazar_mekanik
