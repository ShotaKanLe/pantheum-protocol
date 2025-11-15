<<<<<<< HEAD
extends Node2D

const constantName = 'portal'
var identityNumber = Vector2(0,0)

@export var targetTeleport : Vector2 = Vector2(2,2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _on_area_2d_area_entered(area):
	var obj = area.get_parent()
	teleportTo(obj, targetTeleport)

func teleportTo(obj, to):
	obj.identityNumber = to
	obj.setPlayerPosition(obj.getTileInformation(obj.identityNumber))
	obj.updatePlayerInformation(to)
=======
extends Area2D
class_name Portal

@export var identityNumber: Vector2
@export var target_position: Vector2
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var game = get_tree().get_first_node_in_group("GameController")

var active = false
func _ready():
	connect("body_entered", Callable(self, "_on_enter"))

func _on_enter(body):
	if active:
		if body.name != "char":
			return

		# Cek cooldown dari GameController
		if game.portal_cooldown:
			return

		game.portal_cooldown = true
		for position in game.portalsPosition:
			if position != identityNumber :
				target_position = position
				
		game.teleport_player(target_position)

		# Cooldown global: semua portal diam sementara
		await get_tree().create_timer(0.2).timeout
		game.portal_cooldown = false

func activated():
	active = true
	animated_sprite_2d.play("active")

func deactivated():
	active = false
	animated_sprite_2d.play("inactive")	
>>>>>>> origin/fazar_mekanik
