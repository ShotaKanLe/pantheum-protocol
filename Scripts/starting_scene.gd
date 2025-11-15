extends Node2D

func _ready():
	if Global.isEpilog:
		loadTalkingScene('epilog')
	elif !Global.isProlog:
		loadTalkingScene('realprolog')
		
func loadTalkingScene(param):
	Global.statusLevel = param
	get_tree().change_scene_to_file('res://Scenes/talking_scene.tscn')

func _on_tutorial_1_pressed():
	loadTalkingScene('prolog')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
