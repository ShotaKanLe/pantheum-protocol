extends Area2D
class_name FragileTile

@export var identityNumber: Vector2
@export var max_health := 3
@export var start_broken := false # <-- VARIABEL BARU

var health := 3
var broken := false

@onready var anim := $AnimatedSprite2D
@onready var game := get_tree().get_first_node_in_group("GameController")

func _ready():
	health = max_health
	# VITAL FIX: Jika tile harus rusak dari awal, panggil _break_tile()
	if start_broken:
		_break_tile() # Langsung atur status dan animasi
	else:
		connect("body_exited", Callable(self, "_on_body_exit"))

func _on_body_exit(body):
	if broken: 
		return
	if body.name == "char":
		health -= 1
		
		if health <= 0:
			_break_tile()

func _break_tile():
	broken = true
	health = 0
	var anim_name = "broken_mid"

	# animasi berdasarkan posisi monitor
	if identityNumber.y == 0:
		anim_name = "broken_top"
	elif identityNumber.y == game.gridSize.y - 1:
		anim_name = "broken_bottom"
		anim.offset.y = 7   # disamakan dengan OFFSET_BOTTOM

	anim.position.y -= 4
	anim.play(anim_name)
	

	game.on_tile_broken(identityNumber)
