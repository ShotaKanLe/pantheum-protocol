<<<<<<< HEAD
extends Node2D

var identityNumber = Vector2(0,0)
var comeFromPosition = null
=======
extends CharacterBody2D

var identityNumber = Vector2(0,0)
>>>>>>> origin/fazar_mekanik

func _ready():
	z_index = 1000
	$Timer.start(6)
	doIdleAnimation()
<<<<<<< HEAD
	getTileInformation()
	pass 

func _process(delta):
	movementCharacter()
	pass
	
func movementCharacter():
	if Input.is_action_just_pressed("up"):
		var player = identityNumber
		player.y -= 1
		if (player.y >= 0 and player.y <= Global.GRID_SIZE.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
			comeFromPosition = 'down'
	elif Input.is_action_just_pressed("down"):
		var player = identityNumber
		player.y += 1
		if (player.y >= 0 and player.y <= Global.GRID_SIZE.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
			comeFromPosition = 'up'
	elif Input.is_action_just_pressed("left"):
		var player = identityNumber
		player.x -= 1
		if (player.x >= 0 and player.x <= Global.GRID_SIZE.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
			comeFromPosition = 'right'
	elif Input.is_action_just_pressed("right"):
		var player = identityNumber
		player.x += 1
		if (player.x >= 0 and player.x <= Global.GRID_SIZE.x-1):
			setPlayerPosition(getTileInformation(player))
			updatePlayerInformation(player)
			comeFromPosition = 'left'
			
func setPlayerPosition(tile):
	position.x = tile.position.x
	position.y = tile.position.y+4
	
func getTileInformation(pos = Vector2(0,0)):
	var parent = get_parent()
	var tileManager = parent.get_child(2)
	var tiles = tileManager.get_children()
	for tile in tiles:
		if tile.identityNumber.x == pos.x and tile.identityNumber.y == pos.y:
			return tile

func updatePlayerInformation(newPos):
	identityNumber = newPos
=======
	pass 

var last_direction := Vector2.ZERO

func _physics_process(delta):
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	# Only update when actually moving
	if input_dir != Vector2.ZERO:
		last_direction = input_dir.normalized()
>>>>>>> origin/fazar_mekanik
	
func doBlinkAnimation():
	$AnimatedSprite2D.play("blink")
	
func doIdleAnimation():
	$AnimatedSprite2D.play("idle")

func _on_timer_timeout():
	$Timer.stop()
	doBlinkAnimation()
	await get_tree().create_timer(1.0).timeout
<<<<<<< HEAD
	doIdleAnimation()	
	$Timer.start()
	
func _on_area_2d_area_entered(area):
	var obj = area.get_parent()
	if obj.constantName == 'movableBlock':
		var ifBlockMove = obj.moveBlock(comeFromPosition)
		if ifBlockMove != 'idle':
			obj.moveBlock(comeFromPosition)
		else:
			blockMovement()
	elif obj.constantName == 'staticBlock':
		blockMovement()
		
func blockMovement():
	if comeFromPosition == 'up':
		identityNumber.y -= 1
	elif comeFromPosition == 'down':
		identityNumber.y += 1
	elif comeFromPosition == 'left':
		identityNumber.x -= 1
	elif comeFromPosition == 'right':
		identityNumber.x += 1
		
	setPlayerPosition(getTileInformation(identityNumber))
	updatePlayerInformation(identityNumber)
=======
	doIdleAnimation()
	$Timer.start()
	
>>>>>>> origin/fazar_mekanik
