extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$bgmMainGame.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func showNoButton():
	$startButton.visible = false
	$exitButton.visible = false
	
func showAllButton():
	$startButton.visible = true
	$exitButton.visible = true
	
func _on_button_3_pressed():
	clickButton()
	$levelOption.visible = true
	$startButton.visible = false
	
func clickButton():
	$buttonClick.play()

func _on_exit_button_pressed():
	clickButton()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
	
func loadTalkingScene(param):
	Global.statusLevel = param
	get_tree().change_scene_to_file('res://Scenes/talking_scene.tscn')

func _on_tutorial_1_pressed():
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('prolog')
	
func _on_tutorial_2_pressed():
	if Global.statusLevelTutorial < 1:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	pass # Replace with function body.

func _on_prolog_pressed():
	if Global.statusLevelTutorial < 2:
		return
	Global.statusLevelDesign = 1
	Global.statusLevelNetwork = 1
	Global.statusLevelProgram = 1
	clickButton()
	await get_tree().create_timer(0.5).timeout

func _on_network_1_pressed():
	if Global.statusLevelNetwork < 1:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('network1')

func _on_network_2_pressed():
	if Global.statusLevelNetwork < 2:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('network2')

func _on_network_3_pressed():
	if Global.statusLevelNetwork < 3:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('network3')

func _on_design_1_pressed():
	if Global.statusLevelDesign < 1:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('design1')

func _on_design_2_pressed():
	if Global.statusLevelDesign < 2:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('design2')

func _on_design_3_pressed():
	if Global.statusLevelDesign < 3:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('design3')

func _on_program_1_pressed():
	if Global.statusLevelProgram < 1:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('program1')

func _on_program_2_pressed():
	if Global.statusLevelProgram < 2:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('program2')

func _on_program_3_pressed():
	if Global.statusLevelProgram < 3:
		return
	clickButton()
	await get_tree().create_timer(0.5).timeout
	loadTalkingScene('program3')
