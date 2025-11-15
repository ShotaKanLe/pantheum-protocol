extends Area2D
class_name PressurePlate

@export var identityNumber: Vector2
@export var action_type := "spawn"
@export var action_value : String     # <-- JENIS MECHANIC
@export var target_position : Vector2    # <-- TILE TARGET


@onready var game = get_tree().get_first_node_in_group("GameController")
@onready var animated_sprite_2d := $AnimatedSprite2D

var active := false

func _set_active(state: bool):
	
	active = state

	if active:
		action_type = "spawn"
		animated_sprite_2d.play("on")
		game.execute_action(action_type, action_value, target_position)
	else:
		action_type = "despawn"
		game.execute_action(action_type, action_value, target_position)
		animated_sprite_2d.play("off")


func _on_area_entered(area):
	_set_active(true)


func _on_area_exited(area):
	_set_active(false)

func _on_body_entered(body):
	_set_active(true)

func _on_body_exited(body):
	_set_active(false)   # biar mengikuti flow normal

