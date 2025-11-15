extends Node2D

const ballon = preload("res://Dialogues/balloon.tscn")

@export var dialogue_resource : DialogueResource
@export var dialogue_start: String = 'realprolog'

const abigail = "res://Assets/Head/Abigail.png"
const atlas = "res://Assets/Head/Atlas.png"
const clorina = "res://Assets/Head/Clorina.png"
const darkCyber = "res://Assets/Head/DarkCyber.png"
const dyland = "res://Assets/Head/Dyland.png"
const innera = "res://Assets/Head/Innera.png"
const lyna = "res://Assets/Head/Lyna.png"
const nefa = "res://Assets/Head/Nefa.png"
const vanir = "res://Assets/Head/Vanir.png"
const venrir = "res://Assets/Head/Venrir.png"
const xein = "res://Assets/Head/Xein.png"

func _ready():
	if Global.isEpilog:
		$bgmEpilog.play()
		$bgmEpilog.seek(40)
	elif !Global.isProlog:
		$bgmProlog.play()
	else:
		$bgmMainGame.play()
	showNoChar()
	pass
	
func stopAllMusic():
	$bgmProlog.stop()
	$bgmMainGame.stop()
	$bgmEpilog.stop()

func _process(delta):
	if !State.onConversation:
		space()

func space():
	if Input.is_action_just_pressed("space"):
		playDialog()
		pass
		
func showNoChar():
	$charRight.visible = false
	$charLeft.visible = false
	
func showNoCharLeft():
	$charLeft.visible = false
	
func showNoCharRight():
	$charRight.visible = false
		
func showChar(pos, name):

	if name == 'abigail':
		name = abigail
	elif name == 'atlas':
		name = atlas
	elif name == 'clorina':
		name = clorina
	elif name == '???':
		name = darkCyber
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
	else:
		if pos == 'left':
			showNoCharLeft()
		elif pos == 'right':
			showNoCharRight()
		
	if pos == 'left':
		$charLeft.visible = true
		$charLeft.texture = load(name)
	elif pos == 'right':
		$charRight.visible = true
		$charRight.texture = load(name)
	
func playDialog():
	var ballon : Node = ballon.instantiate()
	get_tree().current_scene.add_child(ballon)
	dialogue_start = Global.statusLevel
	ballon.start(dialogue_resource, dialogue_start)
	
func endProlog():
	Global.isProlog = true
	get_tree().change_scene_to_file('res://Scenes/main_scene.tscn')
	
func endEpilog():
	get_tree().change_scene_to_file('res://Scenes/main_scene.tscn')

	
