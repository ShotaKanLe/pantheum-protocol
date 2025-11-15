extends Area2D
class_name FragileTile

@export var identityNumber: Vector2
@export var max_health := 3
@export var start_broken := false # <-- VARIABEL BARU

var brokenMid = load("res://Assets/TV/broken/brokenMid.png")
var fragileMid = load("res://Assets/TV/broken/fragileMid.png")
var destroyMid = load("res://Assets/TV/broken/destroyMid.png")

var health := 3
var broken := false

@onready var anim := $AnimatedSprite2D
@onready var game := get_tree().get_first_node_in_group("GameController")

func _ready():
	setSprite()
	z_index = 101
	health = max_health
	# VITAL FIX: Jika tile harus rusak dari awal, panggil _break_tile()
	if start_broken:
		_break_tile() # Langsung atur status dan animasi
	else:
		connect("body_exited", Callable(self, "_on_body_exit"))
		
func setSprite():
	$Sprite2D.texture = fragileMid

func _on_body_exit(body):
	if broken: 
		return
	if body.name == "char":
		health -= 1
		
		if health <= 0:
			_break_tile()
		elif health == 2:
			$Sprite2D.texture = fragileMid

		elif health == 1:
			$Sprite2D.texture = destroyMid

func _break_tile():
	broken = true
	health = 0
	$Sprite2D.texture = brokenMid

	game.on_tile_broken(identityNumber)
