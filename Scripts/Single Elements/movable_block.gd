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
