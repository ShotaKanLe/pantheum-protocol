extends Area2D
class_name Bee

var identityNumber : Vector2i
var path : Array = []     # array of Vector2 directions
var path_index := 0
var move_timer := 0.0

const MOVE_INTERVAL := 0.40   # move every 0.4 seconds

func _process(delta):
	move_timer += delta
	if move_timer < MOVE_INTERVAL:
		return

	move_timer = 0

	if path.size() == 0:
		return

	var dir : Vector2i = path[path_index]
	var next := identityNumber + dir

	var game = get_tree().get_first_node_in_group("GameController")

	# only move if the tile is empty
	if game.is_walkable(next):
		move_to(next)

	path_index = (path_index + 1) % path.size()


func move_to(next: Vector2i):
	var game = get_tree().get_first_node_in_group("GameController")

	# update array if you want bee to block tiles
	# game.tileArray[identityNumber.y][identityNumber.x] = null
	# game.tileArray[next.y][next.x] = "bee"

	identityNumber = next
	var tile = game.getTileInformation(next)

	var offset_y := 4
	if next.y == game.gridSize.y - 1:
		offset_y -= 6

	global_position = Vector2(tile.position.x, tile.position.y + offset_y)


func _on_body_entered(body):
	Global.energy = 0
	print("Bee collided with: ", body)
	print("Game Over")
	get_tree().reload_current_scene()
