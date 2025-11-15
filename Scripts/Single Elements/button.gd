extends Area2D
class_name Btn

@export var identityNumber: Vector2
@export var action_type := "spawn"          # contoh: "spawn", "toggle"
@export var action_value := "portal"        # contoh: portal, escalator, monster
@export var target_position : Vector2

@onready var game = get_tree().get_first_node_in_group("GameController")

var active := false

func _ready():
	z_index = 101

func _set_active(state: bool):

	active = state
	if active:
		queue_free()
		game.execute_action(action_type, action_value, target_position)
		
func _on_area_entered(area):
	_set_active(true)

func _on_body_entered(body):
	_set_active(true)

