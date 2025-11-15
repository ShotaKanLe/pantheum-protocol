extends Area2D
class_name Portal

@export var identityNumber: Vector2
@export var target_position: Vector2
@export var startActive := false
var active := false
@onready var game = get_tree().get_first_node_in_group("GameController")
@onready var sprite = $AnimatedSprite2D

func _ready():
	body_entered.connect(_on_enter)

func _on_enter(body):
	if !active: return
	if game.portal_cooldown: return
	if body.name != "char": return

	game.portal_cooldown = true

	game.teleport_player(target_position)

	await get_tree().create_timer(0.15).timeout
	game.portal_cooldown = false

func activated():
	active = true
	sprite.play("active")

func deactivated():
	active = false
	sprite.play("inactive")
