extends CharacterBody2D

var identityNumber : Vector2

var abigail = load('res://Assets/Andro/Abigail.png')
var atlas = load('res://Assets/Andro/Atlas.png')
var clorina = load('res://Assets/Andro/Clorina.png')
var dyland = load('res://Assets/Andro/Dyland.png')
var innera = load('res://Assets/Andro/Innera.png')
var lyna = load('res://Assets/Andro/Lyna.png')
var nefa = load('res://Assets/Andro/Nefa.png')
var vanir = load('res://Assets/Andro/Vanir.png')
var venrir = load('res://Assets/Andro/Venrir.png')
var xein = load('res://Assets/Andro/Xein.png')


func _ready():
	setAvatarAndro(Global.activeCharacter)
	z_index = 1000
	$Timer.start(6)
	pass 

var last_direction := Vector2.ZERO

func setAvatarAndro(name):
	if name == 'abigail':
		name = abigail
	elif name == 'atlas':
		name = atlas
	elif name == 'clorina':
		name = clorina
	elif name == 'dyland': 
		name = dyland
	elif name == 'innera':
		name = innera
	elif name == 'lyna':
		name = lyna
	elif name == 'nefa':
		name = nefa
	elif name == 'vanir':
		name = vanir
	elif name == 'venrir':
		name =venrir
	elif name == 'xein':
		name = xein
		
	$Sprite2D.texture = name
	$Sprite2D2.texture = name

func _physics_process(delta):
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	# Only update when actually moving
	if input_dir != Vector2.ZERO:
		last_direction = input_dir.normalized()
	
