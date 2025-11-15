extends CharacterBody2D

var identityNumber : Vector2

func _ready():
	z_index = 1000
	$Timer.start(6)
	doIdleAnimation()
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
	
func doBlinkAnimation():
	$AnimatedSprite2D.play("blink")
	
func doIdleAnimation():
	$AnimatedSprite2D.play("idle")

func _on_timer_timeout():
	$Timer.stop()
	doBlinkAnimation()
	await get_tree().create_timer(1.0).timeout
	doIdleAnimation()
	$Timer.start()
