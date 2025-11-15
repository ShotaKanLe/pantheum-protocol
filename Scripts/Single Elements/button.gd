extends Area2D
class_name Btn

@export var identityNumber: Vector2
@export var action_type := "spawn"          # contoh: "spawn", "toggle"
@export var action_value := "portal"        # contoh: portal, escalator, monster
@export var target_position : Vector2

@onready var game = get_tree().get_first_node_in_group("GameController")
@onready var animated_sprite_2d := $AnimatedSprite2D

var active := false

func _set_active(state: bool):
	if active == state:
		return
	active = state
	if active:
		animated_sprite_2d.play("on")
		game.execute_action(action_type, action_value, target_position)
	else:
		animated_sprite_2d.play("off")


func _on_area_entered(area):
	_set_active(true)

func _on_body_entered(body):
	_set_active(true)

