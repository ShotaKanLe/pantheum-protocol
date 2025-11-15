extends Area2D
class_name Portal

@export var identityNumber: Vector2
@export var target_position: Vector2
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var game = get_tree().get_first_node_in_group("GameController")

var active = false
func _ready():
	z_index = 400
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
